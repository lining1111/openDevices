//
// Created by lining on 2024/1/4.
//

#ifndef _SLTYPE2_H
#define _SLTYPE2_H

#include <vector>
#include <mutex>
#include "ringbuffer/RingBuffer.h"
#include <thread>
#include <string>
#include <future>

using namespace std;


#include "Poco/Net/SocketReactor.h"
#include "Poco/Net/SocketNotification.h"
#include "Poco/Net/SocketConnector.h"
#include "Poco/Net/SocketAcceptor.h"
#include "Poco/Net/StreamSocket.h"
#include "Poco/Net/ServerSocket.h"
#include "Poco/Net/SocketAddress.h"
#include "Poco/Net/NetException.h"
#include "Poco/Observer.h"
#include "Queue.hpp"
#include <glog/logging.h>

using Poco::Net::SocketReactor;
using Poco::Net::SocketConnector;
using Poco::Net::SocketAcceptor;
using Poco::Net::StreamSocket;
using Poco::Net::ServerSocket;
using Poco::Net::SocketAddress;
using Poco::Net::SocketNotification;
using Poco::Net::ReadableNotification;
using Poco::Net::WritableNotification;
using Poco::Net::TimeoutNotification;
using Poco::Net::ShutdownNotification;
using Poco::Observer;
using Poco::Net::NetException;

/**
 * 信号机通信2,通信链路为tcp，本地起server，在设备的8081界面设置好本地信息后，会接收到信息
 * 信息帧
 * 01 00 04 00 00 00 FF FF DF F3  数据为4字节，小端模式，按位从低到高对应1-16通道，0亮 1灭
 * 03 00 08 00 00 00 00 00 00 04 00 00 00 04 数据为4字节+4字节，第一个按位表示通道，第二个按位表示亮灭 0亮 1灭
 * 分为两类 心跳和实时数据以开头的01 和03 区分 01：心跳 03：实时数据
 *
 */

/**
 * 业务流程1：心跳数据，将所有数据直接用;实时数据只筛选灭的数据，得到后，将相应的通道灯态更新，同时将通道上的值赋值到 *具体路口*的某个方向的红绿灯状态
 * 业务流程2：根据 通道 和 *具体路口*的某个方向的红绿灯状态*的对应关系，将通道上的值赋值到 *具体路口*的某个方向的红绿灯状态
 * 一个通道的状态可能会对应具体路口的多个车道的灯态
 *
 */

#pragma pack(1)
typedef struct {
    uint16_t head;
    uint32_t len;
    uint32_t data1;
    uint32_t data2;
} SLType2Pkg;
#pragma pack()

string GetSLType2PkgStr(SLType2Pkg pkg);


enum SLType2PkgHead {
    SLType2PkgHead_HeartBeat = 0x01,
    SLType2PkgHead_RealTimeData = 0x03,
};


class SLType2TcpServerHandler {
public:
    std::mutex *mtx = nullptr;
    StreamSocket _socket;
    std::string _peerAddress;

    int BUFFER_SIZE = 1024 * 4;
    bool _isRun = false;
    RingBuffer *rb = nullptr;
    SocketReactor &_reactor;
    char *recvBuf = nullptr;

    SLType2Pkg pkgTmp;
    Queue<SLType2Pkg> pkgs;
    //状态机：
    // Start：开始状态，获取一个字节，判断是01 或者03，是的话，进入GetHead
    // GetHead：获取到01或者03后，再获取1个字节，判断是否是00,是的话，进入GetLen，
    //              否则判断是否是01或者03,是的话，进入GetHead，否则，进入Start
    // GetLen：获取4个字节，小端字节处理，判断是否是04或者08，是的话，记录数据的字节数，进入GetBody，否则，进入Start

    // GetBody：获取需要的数据字节数，将完整帧放入缓存，进入Start
    typedef enum {
        Start = 0, GetHead, GetLen, GetBody,
    } RecvStatus;//表示状态机已经达到的状态
    RecvStatus status = Start;
    bool isLocalThreadRun = false;
    shared_future<int> future_t1;
    shared_future<int> future_t2;

public:
    SLType2TcpServerHandler(StreamSocket &socket, SocketReactor &reactor);

    ~SLType2TcpServerHandler();

    void startBusiness();

    void stopBusiness();

    void onReadable(ReadableNotification *pNf);

    void onSocketShutdown(const AutoPtr<ShutdownNotification> &pNf);

    static int ThreadStateMachine(SLType2TcpServerHandler *local);

    static int ThreadProcessPkg(SLType2TcpServerHandler *local);

};


class SLType2 {
public:
    int _port = 35100;//tcp sever port

    Poco::Net::ServerSocket _s;
    Poco::Net::SocketReactor _reactor;
    Poco::Thread _t;
    Poco::Net::SocketAcceptor<SLType2TcpServerHandler> *_acceptor = nullptr;
    bool isListen = false;

public:

    bool isRun = false;
    bool isStartBusiness = false;
    shared_future<int> future_keep;
    typedef struct {
        int channel;//通道号
        int status;//0亮 1灭
    } ChannelStatus;

    vector<ChannelStatus> channelStatusList;//通道状态,索引0---channel1,以此类推

public:
    SLType2(int port);

    SLType2();

    ~SLType2();

    int Open();

    int ReOpen();

    int Run();

    int StartKeep();

    static int ThreadKeep(SLType2 *local);

};


#endif //_SLTYPE2_H
