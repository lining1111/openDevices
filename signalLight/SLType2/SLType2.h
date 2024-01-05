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
#include "common/config.h"

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


/**
 * SLType2本地全局变量，通道状态数组队列
 * 处理：
 * 1、初始化时，往队列插入2个单元，都是1状态。同时调用车道灯态和通道转换函数更新全局Data的缓存内容，头部是old，尾部是new。
 * 2、接收到数据后，根据通道号，更新new通道状态，同时对比old和new的所有通道状态是否改变，如果改变，则将new复制到old，同时调用车道灯态和通道转换函数更新全局Data的缓存内容
 *  状态改变后，调用服务器广播函数，将灯态的变化广播出去
 */

class SLType2ChannelState {
public:
// 通道状态数组
    typedef struct {
        int channel;//1-16
        int state;//0亮 1灭
    } SLType2ChannelStateItem;

    int channelNum = 16;//通道数
    vector<vector<SLType2ChannelStateItem>> store;//存储的状态，队列最新状态在最后面，默认最多2个内容

    SLType2ChannelState();

    SLType2ChannelState(int _channelNum);

    ~SLType2ChannelState();

    void init();

    /**
     * 对应 心跳包的所有状态
     * @param allState
     * @return true 新旧状态不一致 false 新旧状态一致
     */
    bool update(uint32_t allState);

    /**
     * 对应 实时数据的单通道状态
     * @param channelNo
     * @param channelState
     * @return true 新旧状态不一致 false 新旧状态一致
     */
    bool update(int channelNo, int channelState);

    void printStore();

};


extern SLType2ChannelState *slType2ChannelState;


//灯态与通道的对应关系
class SLType2Relation {
public:
    //转换函数用的关系列表 方向-(左转or直行or右转)-通道号
    typedef struct {
        string dir;
        string lightName;//"left" "right" "straight"
        int channel;// -1为未关联通道
    } SLState_Channel;

    int maxDirNum = 8;//最多支持8个方向
    vector<SLState_Channel> relations_SLState_Channel;//关系列表，可以通过ini文件获取格式为 [SL1]下left=1,right=2,straight=3 [SL2]下left=4,right=5,straight=6,依次类推
    SLType2Relation();

    ~SLType2Relation();

    int getFromINI(string path);

};

extern SLType2Relation *slType2Relation;


//全局， slType2ChannelState 通过灯态与通道的对应关系 slType2Relation，将现在所有的通道状态转换为灯态 data->signalLightStates

int SLType2GetSignalLightStates();



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

    std::string msgType = "SignalLight";
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
