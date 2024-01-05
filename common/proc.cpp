//
// Created by lining on 2024/1/4.
//

#include "proc.h"
#include <glog/logging.h>
#include <fmt/core.h>
#include <fmt/ranges.h>
#include "os/os.h"
#include "myTcp/MyTcpHandler.hpp"
#include "myTcp/MyTcpServer.hpp"
#include "myTcp/MyTcpClient.hpp"

void CacheTimestamp::update(int index, uint64_t timestamp, int caches) {
    pthread_mutex_lock(&mtx);
    //如果已经更新了就不再进行下面的操作
    if (!isSetInterval) {
        //判断是否设置了index，index默认为-1
        if (dataIndex == -1) {
            dataIndex = index;
            dataTimestamps.clear();
            dataTimestamps.push_back(timestamp);
        } else {
            //判断是否是对应的index
            if (dataIndex == index) {
                //判断时间戳是否是递增的，如果不是的话，清除之前的内容，重新开始
                if (dataTimestamps.empty()) {
                    //是对应的index的话，将时间戳存进队列
                    dataTimestamps.push_back(timestamp);
                } else {
                    if (timestamp <= dataTimestamps.back()) {
                        //恢复到最初状态
                        LOG(ERROR) << "当前插入时间戳 " << timestamp << " 小于已插入的最新时间戳 "
                                   << dataTimestamps.back() << "，将恢复到最初状态";
                        dataTimestamps.clear();
                        dataIndex = -1;
                    } else {
                        //是对应的index的话，将时间戳存进队列，正常插入
                        dataTimestamps.push_back(timestamp);
                    }
                }
            }
        }
        //如果存满缓存帧后，计算帧率，并设置标志位
        if (dataTimestamps.size() == caches) {
            //打印下原始时间戳队列
            LOG(WARNING) << "动态帧率原始时间戳队列:" << fmt::format("{}", dataTimestamps);
            std::vector<uint64_t> intervals;
            for (int i = 1; i < dataTimestamps.size(); i++) {
                auto cha = dataTimestamps.at(i) - dataTimestamps.at(i - 1);
                intervals.push_back(cha);
            }
            //计算差值的平均数
            uint64_t sum = 0;
            for (auto iter: intervals) {
                sum += iter;
            }
            this->interval = sum / intervals.size();
//            printf("帧率的差和为%d\n", sum);
//            printf("计算的帧率为%d\n", this->interval);
            this->isSetInterval = true;
        }
    }
    pthread_mutex_unlock(&mtx);
}

int PkgProcessFun_CmdResponse(void *p, string content) {
    VLOG(2) << "应答指令";
    int ret = 0;
    auto local = (MyTcpClient *) p;
    string ip = local->_peerAddress;

    string msgType = "Reply";
    Reply msg;
    try {
        json::decode(content, msg);
    } catch (std::exception &e) {
        LOG(ERROR) << e.what();
        return -1;
    }

    //1.记录下接收回复的时间
    local->timeRecv = std::chrono::duration_cast<std::chrono::milliseconds>(
            std::chrono::system_clock::now().time_since_epoch()).count();
    //2.检验下回复时间和发送时间的差，是否大于阈值，大于就重连
    if (localConfig.isUseThresholdReconnect) {
        if (std::abs((long long) local->timeRecv - (long long) local->timeSend) >=
            (1000 * localConfig.thresholdReconnect)) {
            LOG(WARNING) << "接收和发送时间差大于阈值，需要重连，ip:" << ip
                         << " timeRecv:" << local->timeRecv << " timeSend:" << local->timeSend
                         << " oprNum:" << msg.oprNum;
            local->isNeedReconnect = true;
        }
    }

    return ret;
}

int PkgProcessFun_CmdHeartBeat(void *p, string content) {
    VLOG(2) << "心跳指令";
    auto local = (MyTcpHandler *) p;
    return 0;
}

int PkgProcessFun_CmdSignalLightState(void *p, string content) {
    VLOG(4) << content;
    int ret = 0;
    auto local = (MyTcpServerHandler *) p;

    string ip = local->_peerAddress;

    string msgType = "SignalLightState";
    SignalLightState msg;
    try {
        json::decode(content, msg);
    } catch (std::exception &e) {
        LOG(ERROR) << e.what();
        return -1;
    }

    if (msg.hardCode.empty()) {
        LOG(ERROR) << "hardCode empty," << content;
        return -1;
    }

    if (msg.crossID.empty()) {
        LOG(ERROR) << "crossID empty," << content;
        return -1;
    }


    auto *data = Data::instance();

    //判断下路口id是否一致
    if (msg.crossID != data->plateId) {
        LOG(ERROR) << "crossID:" << msg.crossID << "!=" << data->plateId;
        return -1;
    }

    auto dataUnit = data->signalLightStates;
    SignalLightState msgSend;
    std::unique_lock<std::mutex> lock(data->mtx_signalLightStates);
    if (dataUnit.empty()) {
        msgSend.crossID = data->plateId;
        msgSend.hardCode = data->matrixNo;
        msgSend.timestamp = os::getTimestampMs();
    } else {
        msgSend = dataUnit.back();
    }

    uint32_t deviceNo = stoi(data->matrixNo.substr(0, 10));
    Pkg pkg;
    msgSend.PkgWithoutCRC(data->sn_SignalLightState, deviceNo, pkg);
    data->sn_SignalLightState++;

    if (!local->SendBase(pkg)) {
        LOG_IF(INFO, isShowMsgType(msgType)) << "client ip:" << ip << " " << msgType << ",发送消息失败";
        ret = -1;
    } else {
        LOG_IF(INFO, isShowMsgType(msgType)) << "client ip:" << ip << " " << msgType << ",发送消息成功，"
                                             << "hardCode:" << msgSend.hardCode << " crossID:" << msgSend.crossID
                                             << "timestamp:" << (uint64_t) msgSend.timestamp;
    }
    return ret;

}

map<CmdType, PkgProcessFun> PkgProcessMap = {
        make_pair(CmdResponse, PkgProcessFun_CmdResponse),
        make_pair(CmdHeartBeat, PkgProcessFun_CmdHeartBeat),

        make_pair(CmdSignalLightState, PkgProcessFun_CmdSignalLightState),
};
