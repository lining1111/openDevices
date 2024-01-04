//
// Created by lining on 2023/8/22.
//

#ifndef RVDATAFUSIONSERVER_MYTCPHANDLER_H
#define RVDATAFUSIONSERVER_MYTCPHANDLER_H

#include "common/common.h"
#include "common/CRC.h"
#include "common/proc.h"
#include "common/config.h"
#include "ringbuffer/RingBuffer.h"
#include "Queue.hpp"
#include <glog/logging.h>
#include <thread>
#include <vector>
#include <string>
#include <future>

using namespace std;

#include "Poco/Net/StreamSocket.h"
using Poco::Net::StreamSocket;


class MyTcpHandler {
public:
    std::mutex *mtx = nullptr;
    StreamSocket _socket;
    std::string _peerAddress;

    int BUFFER_SIZE = 1024 * 1024 * 4;
    bool _isRun = false;
    RingBuffer *rb = nullptr;
    Queue<common::Pkg> pkgs;
    //接收buffer状态机 Start开始---从接收的数据中寻找帧头开始(开始为特殊字符$)GetHeadStart---找到帧头开始，获取全部帧头信息(一共9字节)GetHead---
    //获取全部帧头信息后，根据帧头信息的帧内容长度信息，获取全部帧内容GetBody---获取完身体后，获取CRC GETCRC---获取完全部帧内容后，回到开始状态Start
    typedef enum {
        Start = 0, GetHeadStart, GetHead, GetBody, GetCRC,
    } RecvStatus;//表示状态机已经达到的状态
    RecvStatus status = Start;
    //用于缓存解包
    common::PkgHead pkgHead;//分包头
    uint64_t bodyLen = 0;//获取分包头后，得到的包长度
    uint8_t *pkgBuffer = nullptr;
    int pkgBufferIndex = 0;

    bool isLocalThreadRun = false;
    shared_future<int> future_t1;
    shared_future<int> future_t2;
    uint64_t timeSend = 0;
    uint64_t timeRecv = 0;

    MyTcpHandler() {
        if (mtx == nullptr) {
            mtx = new std::mutex();
        }
        rb = new RingBuffer(BUFFER_SIZE);
        pkgs.setMax(30);
    }

    ~MyTcpHandler() {
        if (rb != nullptr) {
            delete rb;
            rb = nullptr;
        }
        LOG(WARNING) << _peerAddress << " release";
        delete mtx;
    }

    void startBusiness() {
        _isRun = true;
        LOG(WARNING) << _peerAddress << " start business";
        isLocalThreadRun = true;
        future_t1 = std::async(std::launch::async, ThreadStateMachine, this);
        future_t2 = std::async(std::launch::async, ThreadProcessPkg, this);

    }

    void stopBusiness() {
        _isRun = false;

        if (isLocalThreadRun) {
            isLocalThreadRun = false;
            try {
                future_t1.wait();
            } catch (exception &e) {
                LOG(ERROR) << e.what();
            }
            try {
                future_t2.wait();
            } catch (exception &e) {
                LOG(ERROR) << e.what();
            }
        }
        LOG(WARNING) << _peerAddress << " stop business";
    }

    static int ThreadStateMachine(MyTcpHandler *local) {
        LOG(WARNING) << local->_peerAddress << " ThreadStateMachine start";
        while (local->_isRun) {
            usleep(10);
            if (local->rb == nullptr) {
                //数据缓存区不存在
                continue;
            }
            if (local->rb->GetReadLen() == 0) {
                continue;
            }

            //分包状态机
            switch (local->status) {
                case Start: {
                    //开始,寻找包头的开始标志
                    if (local->rb->GetReadLen() >= MEMBER_SIZE(PkgHead, tag)) {
                        char start = '\0';
                        local->rb->Read(&start, sizeof(start));
                        if (start == '$') {
                            //找到开始标志
                            local->status = GetHeadStart;
                        }
                    }
                }
                    break;
                case GetHeadStart: {
                    //开始寻找头
                    if (local->rb->GetReadLen() >= (sizeof(PkgHead) - MEMBER_SIZE(PkgHead, tag))) {
                        //获取完整的包头
                        local->pkgHead.tag = '$';
                        local->rb->Read(&local->pkgHead.version, (sizeof(PkgHead) - MEMBER_SIZE(PkgHead, tag)));
                        //buffer申请内存
                        local->pkgBuffer = new uint8_t[local->pkgHead.len];
                        local->pkgBufferIndex = 0;
                        memcpy(local->pkgBuffer, &local->pkgHead, sizeof(pkgHead));
                        local->pkgBufferIndex += sizeof(pkgHead);
                        local->status = GetHead;
                        local->bodyLen = local->pkgHead.len - sizeof(PkgHead) - sizeof(PkgCRC);
                    }
                }
                    break;
                case GetHead: {
                    if (0) {
                        //这个是一次性获取全部包内容
                        if (local->rb->GetReadLen() >= local->bodyLen) {
                            //获取正文
                            uint64_t readLen = local->bodyLen;
                            local->rb->Read(local->pkgBuffer + local->pkgBufferIndex, readLen);
                            local->pkgBufferIndex += readLen;
                            local->status = GetBody;
                        }
                    } else {
                        //这个是分多次获取包内容
                        uint64_t canRead = local->rb->GetReadLen();
                        uint64_t readLen = canRead < local->bodyLen ? canRead : local->bodyLen;
                        //获取正文
                        local->rb->Read(local->pkgBuffer + local->pkgBufferIndex, readLen);
                        local->bodyLen -= readLen;
                        local->pkgBufferIndex += readLen;

                        if (local->bodyLen == 0) {
                            local->status = GetBody;
                        }
                    }

                }
                    break;
                case GetBody: {
                    if (local->rb->GetReadLen() >= sizeof(PkgCRC)) {
                        //获取CRC
                        local->rb->Read(local->pkgBuffer + local->pkgBufferIndex, sizeof(PkgCRC));
                        local->pkgBufferIndex += sizeof(PkgCRC);
                        local->status = GetCRC;
                    }
                }
                    break;
                case GetCRC: {
                    //获取CRC 就获取全部的分包内容，转换为结构体
                    Pkg pkg;

                    if (Unpack(local->pkgBuffer, local->pkgHead.len, pkg) != 0) {
                        LOG(ERROR) << local->_peerAddress << "cmd:" << to_string(pkg.head.cmd)
                                   << " unpack err";
                        local->bodyLen = 0;//获取分包头后，得到的包长度
                        if (local->pkgBuffer != nullptr) {
                            delete[] local->pkgBuffer;
                            local->pkgBuffer = nullptr;
                        }
                        local->pkgBufferIndex = 0;//分包缓冲的索引
                        local->status = Start;
                    } else {
                        //接包正确，判断CRC是否正确
                        uint16_t crc = Crc16TabCCITT(local->pkgBuffer, local->pkgHead.len - 2);
                        if (crc != pkg.crc.data) {//CRC校验失败
                            LOG(ERROR) << local->_peerAddress << "cmd:" << to_string(pkg.head.cmd)
                                       << " CRC fail, 计算值:" << crc << ",包内值:" << pkg.crc.data;
                            local->bodyLen = 0;//获取分包头后，得到的包长度
                            if (local->pkgBuffer != nullptr) {
                                delete[] local->pkgBuffer;
                                local->pkgBuffer = nullptr;
                            }
                            local->pkgBufferIndex = 0;//分包缓冲的索引
                            local->status = Start;
                        } else {
                            VLOG(4) << local->_peerAddress << " 包内容：" << pkg.body;
                            //存入分包队列
                            if (!local->pkgs.push(pkg)) {
                                VLOG(2) << local->_peerAddress << " 包缓存压入失败";
                            } else {
                                VLOG(2) << local->_peerAddress << " 包缓存压入成功";
                            }
                            local->bodyLen = 0;//获取分包头后，得到的包长度
                            if (local->pkgBuffer != nullptr) {
                                delete[] local->pkgBuffer;
                                local->pkgBuffer = nullptr;
                            }
                            local->pkgBufferIndex = 0;//分包缓冲的索引
                            local->status = Start;
                        }
                    }
                }
                    break;
                default: {
                    //意外状态错乱后，回到最初
                    local->bodyLen = 0;//获取分包头后，得到的包长度
                    if (local->pkgBuffer != nullptr) {
                        delete[] local->pkgBuffer;
                        local->pkgBuffer = nullptr;
                    }
                    local->pkgBufferIndex = 0;//分包缓冲的索引
                    local->status = Start;
                }
                    break;
            }
        }
        LOG(WARNING) << local->_peerAddress << " ThreadStateMachine end";
        return 0;
    }

    static int ThreadProcessPkg(MyTcpHandler *local) {
        LOG(WARNING) << local->_peerAddress << " ThreadProcessPkg start";
        while (local->_isRun) {
            usleep(10);
            common::Pkg pkg;
            if (local->pkgs.pop(pkg)) {
                //按照cmd分别处理
                auto iter = PkgProcessMap.find(CmdType(pkg.head.cmd));
                if (iter != PkgProcessMap.end()) {
                    iter->second(local, pkg.body);
                } else {
                    //最后没有对应的方法名
                    VLOG(2) << local->_peerAddress << " 最后没有对应的方法名:" << pkg.head.cmd << ",内容:" << pkg.body;
                }
            }
        }
        LOG(WARNING) << local->_peerAddress << " ThreadProcessPkg end";
        return 0;
    }

};


#endif //RVDATAFUSIONSERVER_MYTCPHANDLER_H
