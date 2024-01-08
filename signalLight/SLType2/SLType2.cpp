//
// Created by lining on 2024/1/4.
//

#include "SLType2.h"
#include <fmt/format.h>
#include <fmt/ranges.h>
#include <bitset>
#include "os/os.h"

SLType2ChannelState *slType2ChannelState = nullptr;

SLType2Relation *slType2Relation = nullptr;

SLType2ChannelState::SLType2ChannelState() {
    init();
}

SLType2ChannelState::SLType2ChannelState(int _channelNum) : channelNum(_channelNum) {
    init();
}

SLType2ChannelState::~SLType2ChannelState() {

}

void SLType2ChannelState::init() {
    vector<SLType2ChannelStateItem> item;
    for (int i = 0; i < this->channelNum; i++) {
        SLType2ChannelStateItem item1;
        item1.channel = i + 1;
        item1.state = 1;
        item.push_back(item1);
    }
    this->store.push_back(item);
    this->store.push_back(item);

}

bool SLType2ChannelState::update(uint32_t allState) {
    //将旧的更新到之前新的
    this->store.at(0) = this->store.at(1);
    //更新现在的状态
    auto now = this->store.at(1);
    auto old = this->store.at(0);
    //将 uint32_t 转换为bitset 32
    bitset<32> bs(allState);
    //打印转换细节
    VLOG(2) << "allState:" << to_string(allState) << "  bs:" << bs.to_string() << endl;

    for (int i = 0; i < this->channelNum; i++) {
        now.at(i).state = bs[i];
    }

    //更新状态
    this->store.at(1) = now;
    //打印下新旧数组值
    printStore();

    //对比新旧是否一致
    bool ret = true;
    for (int i = 0; i < this->channelNum; i++) {
        if (now.at(i).state != old.at(i).state) {
            ret = false;
            break;
        }
    }
    return ret;
}

bool SLType2ChannelState::update(int channelNo, int channelState) {
    //将旧的更新到之前新的
    this->store.at(0) = this->store.at(1);
    //更新现在的状态
    auto now = this->store.at(1);
    auto old = this->store.at(0);

    //打印转换细节
    VLOG(2) << "channelNo:" << to_string(channelNo) << "，channelState:" << to_string(channelState);

    for (int i = 0; i < this->channelNum; i++) {
        if (now.at(i).channel == channelNo) {
            now.at(i).state = channelState;
            break;
        }
    }

    //更新状态
    this->store.at(1) = now;
    //打印下新旧数组值
    printStore();

    //对比新旧是否一致
    bool ret = true;
    for (int i = 0; i < this->channelNum; i++) {
        if (now.at(i).state != old.at(i).state) {
            ret = false;
            break;
        }
    }
    return ret;
}

void SLType2ChannelState::printStore() {
    string content;
    //old
    content.clear();
    content += "old:";
    for (int i = 0; i < this->channelNum; i++) {
        content += to_string(store.at(0).at(i).channel);
        content += ":";
        content += to_string(store.at(0).at(i).state);
        content += ",";
    }
    VLOG(2) << content;
    content.clear();
    content += "new:";
    for (int i = 0; i < this->channelNum; i++) {
        content += to_string(store.at(1).at(i).channel);
        content += ":";
        content += to_string(store.at(1).at(i).state);
        content += ",";
    }
    VLOG(2) << content;
}

SLType2Relation::SLType2Relation() {
    if (getFromINI(localConfig.iniPath) == 0) {
        LOG(WARNING) << "SLType2 获取灯态和通道的关系成功";
    } else {
        LOG(ERROR) << "SLType2 获取灯态和通道的关系失败";
    }
}

SLType2Relation::~SLType2Relation() {

}

#include "Poco/Util/Application.h"
#include "Poco/Path.h"
#include "Poco/AutoPtr.h"
#include "Poco/Util/IniFileConfiguration.h"

int SLType2Relation::getFromINI(string path) {
    int ret = 0;
    try {
        Poco::AutoPtr<Poco::Util::IniFileConfiguration> pConf(new Poco::Util::IniFileConfiguration(path));
        for (int i = 0; i < maxDirNum; i++) {
            SLState_Channel item;
            string key = "SignalLight_" + to_string(i);
            item.dir = to_string(i);
            //left
            item.left = pConf->getInt(key + "." + "left", -1);
            //straight
            item.straight = pConf->getInt(key + "." + "straight", -1);
            //right
            item.right = pConf->getInt(key + "." + "right", -1);

            relations_SLState_Channel.push_back(item);

        }

        //打印下配置获取
        string content = "SLType2 获取灯态和通道的关系成功\n";
        for (int i = 0; i < relations_SLState_Channel.size(); i++) {
            content += "dir:" + relations_SLState_Channel[i].dir +
                       " left:" + to_string(relations_SLState_Channel[i].left) +
                       " straight:" + to_string(relations_SLState_Channel[i].straight) +
                       " right:" + to_string(relations_SLState_Channel[i].right) + "\n";
        }
        LOG(WARNING) << content;
        ret = 0;
    }
    catch (Poco::Exception &exc) {
        std::cerr << exc.displayText() << std::endl;
        ret = -1;
    }
    return ret;
}

int SLType2GetSignalLightStates() {

    auto *data = Data::instance();
    //将旧的更新到旧的上，新的更新到新的上
    //将未更新的新的赋值到旧的
    data->signalLightStates.at(0) = data->signalLightStates.at(1);
    //更新新的
    auto channelStates = &slType2ChannelState->store.at(1);
    auto signalLightStates = &data->signalLightStates.at(1);

    //新灯态更新uuid和时间戳
    uuid_t uuid;
    char uuid_str[37];
    memset(uuid_str, 0, 37);
    uuid_generate_time(uuid);
    uuid_unparse(uuid, uuid_str);
    signalLightStates->oprNum = string(uuid_str);
    signalLightStates->timestamp = os::getTimestampMs();

    //遍历通道状态数组，取出通道号和状态，然后遍历关系图，将状态赋值到关系中是该通道的灯态
    for (auto &channelState: *channelStates) {
        int channel = channelState.channel;
        int state = channelState.state;
        //灯名---通道
        for (auto relation: slType2Relation->relations_SLState_Channel) {
            //左转相同
            if (relation.left == channel) {
                //通道号相同，将状态赋值给对应的灯态
                //要更新的方向
                auto matrixNo = relation.dir;
                //遍历灯态数组，根据方向值找到要更新的方向
                for (auto &signalLightState: signalLightStates->lstIntersections) {
                    if (signalLightState.matrixNo == matrixNo) {
                        //方向相同，然后根据灯名更新状态
                        signalLightState.left = state;
                        LOG_IF(INFO, isShowMsgType("SignalLight"))
                                        << "更新灯态:" << "channel:" << to_string(channel) << ",state:"
                                        << to_string(state)
                                        << ",matrixNo:" << matrixNo << ",lightName:left" << ",state:"
                                        << to_string(signalLightState.left);
                        break;
                    }
                }
            }

            //直行相同
            if (relation.straight == channel) {
                //通道号相同，将状态赋值给对应的灯态
                //要更新的方向
                auto matrixNo = relation.dir;
                //遍历灯态数组，根据方向值找到要更新的方向
                for (auto &signalLightState: signalLightStates->lstIntersections) {
                    if (signalLightState.matrixNo == matrixNo) {
                        //方向相同，然后根据灯名更新状态
                        signalLightState.straight = state;
                        LOG_IF(INFO, isShowMsgType("SignalLight"))
                                        << "更新灯态:" << "channel:" << to_string(channel) << ",state:"
                                        << to_string(state)
                                        << ",matrixNo:" << matrixNo << ",lightName:straight" << ",state:"
                                        << to_string(signalLightState.straight);
                        break;
                    }
                }
            }

            //右转相同
            if (relation.right == channel) {
                //通道号相同，将状态赋值给对应的灯态
                //要更新的方向
                auto matrixNo = relation.dir;
                //遍历灯态数组，根据方向值找到要更新的方向
                for (auto &signalLightState: signalLightStates->lstIntersections) {
                    if (signalLightState.matrixNo == matrixNo) {
                        //方向相同，然后根据灯名更新状态
                        signalLightState.right = state;
                        LOG_IF(INFO, isShowMsgType("SignalLight"))
                                        << "更新灯态:" << "channel:" << to_string(channel) << ",state:"
                                        << to_string(state)
                                        << ",matrixNo:" << matrixNo << ",lightName:right" << ",state:"
                                        << to_string(signalLightState.right);
                        break;
                    }
                }
            }
        }
    }
    return 0;
}


string GetSLType2PkgStr(SLType2Pkg pkg) {
    string content;
    uint8_t *buf = new uint8_t[sizeof(pkg)];
    memcpy(buf, &pkg, sizeof(pkg));
    int len = pkg.len + 6;
    vector<uint8_t> v_buf;
    for (int i = 0; i < len; i++) {
        v_buf.push_back(buf[i]);
    }
    delete[]buf;
    content = fmt::format("{::x}", v_buf);
    return content;
}

SLType2TcpServerHandler::SLType2TcpServerHandler(StreamSocket &socket, SocketReactor &reactor) :
        _reactor(reactor) {
    _socket = socket;
    _peerAddress = socket.peerAddress().toString();
    LOG(WARNING) << "connection from " << _peerAddress << " ...";

    if (mtx == nullptr) {
        mtx = new std::mutex();
    }
    rb = new RingBuffer(BUFFER_SIZE);
    pkgs.setMax(30);

    recvBuf = new char[1024];

    _reactor.addEventHandler(_socket, Observer<SLType2TcpServerHandler, ReadableNotification>(*this,
                                                                                              &SLType2TcpServerHandler::onReadable));
    _reactor.addEventHandler(_socket, NObserver<SLType2TcpServerHandler, ShutdownNotification>(*this,
                                                                                               &SLType2TcpServerHandler::onSocketShutdown));
    startBusiness();
}


SLType2TcpServerHandler::~SLType2TcpServerHandler() {
    LOG(WARNING) << _peerAddress << " disconnected ...";
    stopBusiness();

    if (rb != nullptr) {
        delete rb;
        rb = nullptr;
    }
    delete mtx;

    _reactor.removeEventHandler(_socket, Observer<SLType2TcpServerHandler, ReadableNotification>(*this,
                                                                                                 &SLType2TcpServerHandler::onReadable));
    _reactor.removeEventHandler(_socket, NObserver<SLType2TcpServerHandler, ShutdownNotification>(*this,
                                                                                                  &SLType2TcpServerHandler::onSocketShutdown));

    delete[]recvBuf;
}


void SLType2TcpServerHandler::startBusiness() {
    _isRun = true;
    LOG(WARNING) << _peerAddress << " start business";
    isLocalThreadRun = true;
    future_t1 = std::async(std::launch::async, ThreadStateMachine, this);
    future_t2 = std::async(std::launch::async, ThreadProcessPkg, this);
}

void SLType2TcpServerHandler::stopBusiness() {
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

void SLType2TcpServerHandler::onReadable(ReadableNotification *pNf) {
    pNf->release();
    if (rb == nullptr) {
        LOG(ERROR) << _peerAddress << " rb null";
        return;
    }

    bzero(recvBuf, 1024);
    int recvLen = (rb->GetWriteLen() < (1024)) ? rb->GetWriteLen() : (1024);
    try {
        int len = _socket.receiveBytes(recvBuf, recvLen);
        if (len <= 0) {
            LOG(WARNING) << _peerAddress << " receive len <=0";
            delete this;
        } else {
            rb->Write(recvBuf, len);
            VLOG(2) << _peerAddress << " receive len:" << len;
        }
    }
    catch (Poco::Exception &exc) {
        LOG(WARNING) << exc.what();
        delete this;
    }
}

void SLType2TcpServerHandler::onSocketShutdown(const AutoPtr<ShutdownNotification> &pNf) {
    pNf->release();
    delete this;
}


int SLType2TcpServerHandler::ThreadStateMachine(SLType2TcpServerHandler *local) {
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
                if (local->rb->GetReadLen() >= 1) {
                    uint8_t tmp;
                    local->rb->Read(&tmp, sizeof(tmp));
                    switch (tmp) {
                        case SLType2PkgHead_HeartBeat:
                        case SLType2PkgHead_RealTimeData: {
                            //找到开始标志
                            local->status = GetHead;
                            local->pkgTmp.head = tmp;//这个是暂存值，如果后面跟的不是00,则需要清除
                        }
                            break;
                        default: {
                            local->status = Start;
                        }
                            break;
                    }
                }
            }
                break;
            case GetHead: {
                //开始寻找头
                if (local->rb->GetReadLen() >= 1) {
                    //判断的到的字节是否是00
                    uint8_t tmp;
                    local->rb->Read(&tmp, sizeof(tmp));
                    switch (tmp) {
                        case 0x00: {
                            local->status = GetLen;
                        }
                            break;
                        case 0x01:
                        case 0x03: {
                            local->status = GetHead;
                            local->pkgTmp.head = tmp;//这个是暂存值，如果后面跟的不是00,则需要清除
                        }
                            break;
                        default: {
                            local->status = Start;
                        }
                            break;
                    }
                }
            }
                break;
            case GetLen: {
                if (local->rb->GetReadLen() >= 4) {
                    uint32_t tmp;
                    local->rb->Read(&tmp, sizeof(tmp));
                    switch (tmp) {
                        case 0x04:
                        case 0x08: {
                            local->status = GetBody;
                            local->pkgTmp.len = tmp;
                        }
                            break;
                        default: {
                            local->status = Start;
                        }
                            break;
                    }
                }
            }
                break;
            case GetBody: {
                if (local->rb->GetReadLen() >= local->pkgTmp.len) {
                    local->status = Start;
                    uint8_t *bodyTmp = new uint8_t[local->pkgTmp.len];
                    local->rb->Read(bodyTmp, local->pkgTmp.len);
                    switch (local->pkgTmp.len) {
                        case 0x04: {
                            memcpy(&local->pkgTmp.data1, bodyTmp, 4);
                        }
                            break;
                        case 0x08: {
                            memcpy(&local->pkgTmp.data1, bodyTmp, 4);
                            memcpy(&local->pkgTmp.data2, bodyTmp + 4, 4);
                        }
                            break;
                        default: {

                        }
                            break;
                    }
                    delete[]bodyTmp;

                    //将数据压入缓存
                    if (local->pkgs.push(local->pkgTmp)) {
                        VLOG(2) << "SLType2TcpServerHandler push pkg success:" << GetSLType2PkgStr(local->pkgTmp);
                    } else {
                        VLOG(2) << "SLType2TcpServerHandler push pkg fail:" << GetSLType2PkgStr(local->pkgTmp);
                    }
                }
            }
                break;
            default: {
                //意外状态错乱后，回到最初
                local->status = Start;
            }
                break;
        }
    }
    LOG(WARNING) << local->_peerAddress << " ThreadStateMachine end";
    return 0;
}

int SLType2TcpServerHandler::ThreadProcessPkg(SLType2TcpServerHandler *local) {
    LOG(WARNING) << local->_peerAddress << " ThreadProcessPkg start";
    while (local->_isRun) {
        usleep(10);
        SLType2Pkg pkg;
        if (local->pkgs.pop(pkg)) {
            //根据包的类型，进行不同的处理
            VLOG(2) << "SLType2TcpServerHandler pop pkg success:" << GetSLType2PkgStr(pkg);
            switch (pkg.head) {
                case SLType2PkgHead_HeartBeat: {
                    //处理心跳数据
                    if (slType2ChannelState != nullptr) {

                        uint32_t allState = ((pkg.data1 & 0xffff0000) >> 16);
                        if (!slType2ChannelState->update(allState)) {
                            //状态变化了，通过转换函数更新本地数据，并广播出去
                            LOG_IF(INFO, isShowMsgType(local->msgType)) << "状态有变化,更新本地数据，并广播出去";
                            //通过转换函数更新本地数据
                            SLType2GetSignalLightStates();
                            //广播
                            auto *data = Data::instance();
                            data->broadcastSignalLightStates();
                        } else {
                            LOG_IF(INFO, isShowMsgType(local->msgType)) << "状态无变化";
                        }
                    }
                }
                    break;
                case SLType2PkgHead_RealTimeData: {
                    //处理实时数据
                    //将实时数据的data1转换为通道，实时数据的data2转换为状态
                    int channel = 0;
                    int state = 0;
                    //获取通道
                    {
                        bitset<16> bs_1_16(((pkg.data1 & 0xffff0000) >> 16));

                        if (bs_1_16.count() == 1) {
                            for (int i = 0; i < bs_1_16.size(); i++) {
                                if (bs_1_16[i]) {
                                    channel = i + 1;
                                    break;
                                }
                            }
                        }
                        VLOG(2) << "实时数据,data1:" << to_string(pkg.data1) << ",bs:" << bs_1_16.to_string()
                                << ",channel:" << to_string(channel);
                    }
                    //获取状态
                    {
                        if (channel != 0) {
                            //在有通道值的情况下，取值
                            bitset<16> bs_1_16(((pkg.data2 & 0xffff0000) >> 16));

                            state = bs_1_16[channel - 1];
                            VLOG(2) << "实时数据,data2:" << to_string(pkg.data2) << ",bs:" << bs_1_16.to_string()
                                    << ",state:" << to_string(state);
                        }
                    }

                    //只有灭的时候才处理
                    if ((channel != 0) && (state != 0)) {
                        LOG_IF(INFO, isShowMsgType(local->msgType))
                                        << "channel:" << to_string(channel) << ",state:" << to_string(state)
                                        << " 灯灭状态，处理";
                        if (slType2ChannelState != nullptr) {
                            if (!slType2ChannelState->update(channel, state)) {
                                //状态变化了，通过转换函数更新本地数据，并广播出去
                                LOG_IF(INFO, isShowMsgType(local->msgType)) << "状态有变化,更新本地数据，并广播出去";
                                //通过转换函数更新本地数据
                                SLType2GetSignalLightStates();
                                //广播
                                auto *data = Data::instance();
                                data->broadcastSignalLightStates();
                            } else {
                                LOG_IF(INFO, isShowMsgType(local->msgType)) << "状态无变化";
                            }
                        }
                    } else {
                        LOG_IF(INFO, isShowMsgType(local->msgType))
                                        << "channel:" << to_string(channel) << ",state:" << to_string(state)
                                        << " 灯亮状态，不处理";
                    }
                }
                    break;
                default: {

                }
                    break;
            }

        }
    }
    LOG(WARNING) << local->_peerAddress << " ThreadProcessPkg end";
    return 0;
}


SLType2::SLType2(int port) : _port(port) {
    if (slType2ChannelState == nullptr) {
        slType2ChannelState = new SLType2ChannelState(16);
    }
    if (slType2Relation == nullptr) {
        slType2Relation = new SLType2Relation();
    }
}

SLType2::SLType2() {
    if (slType2ChannelState == nullptr) {
        slType2ChannelState = new SLType2ChannelState(16);
    }
    if (slType2Relation == nullptr) {
        slType2Relation = new SLType2Relation();
    }
}

SLType2::~SLType2() {
    delete _acceptor;
    isRun = false;

    if (isStartBusiness) {
        isStartBusiness = false;
        try {
            future_keep.wait();
        } catch (exception &e) {
            LOG(ERROR) << e.what();
        }
    }

    if (slType2ChannelState != nullptr) {
        delete slType2ChannelState;
        slType2ChannelState = nullptr;
    }
}

int SLType2::Open() {
    try {
        _s.bind(Poco::Net::SocketAddress(_port));
        _s.listen();
        _s.setReuseAddress(true);
        _s.setReusePort(true);
    } catch (Poco::Exception &exc) {
        LOG(ERROR) << exc.what();
        isListen = false;
        return -1;
    }
    _acceptor = new Poco::Net::SocketAcceptor<SLType2TcpServerHandler>(_s, _reactor);
    isListen = true;
    return 0;
}

int SLType2::ReOpen() {
    try {
        _s.close();
        _s.bind(Poco::Net::SocketAddress(_port));
        _s.listen();
        _s.setReuseAddress(true);
        _s.setReusePort(true);
    } catch (Poco::Exception &exc) {
        LOG(ERROR) << exc.what();
        isListen = false;
        return -1;
    }
    if (_acceptor != nullptr) {
        delete _acceptor;
    }
    _acceptor = new Poco::Net::SocketAcceptor<SLType2TcpServerHandler>(_s, _reactor);
    isListen = true;
    return 0;
}


int SLType2::Run() {
    //Starting TCP Server
    _t.start(_reactor);
    LOG(WARNING) << _port << "-Server Started";
    LOG(WARNING) << _port << "-Ready To Accept the connections";
    return 0;
}

int SLType2::StartKeep() {
    isRun = true;
    isStartBusiness = true;

    future_keep = std::async(std::launch::async, ThreadKeep, this);

    return 0;
}

int SLType2::ThreadKeep(SLType2 *local) {
    LOG(WARNING) << local->_port << "-ThreadKeep START";

    while (local->isRun) {
        std::this_thread::sleep_for(std::chrono::seconds(1));
        if (!local->isListen) {
            local->ReOpen();
            if (local->isListen) {
                LOG(WARNING) << local->_port << "-ThreadKeep ReOpen Success";
            } else {
                LOG(WARNING) << local->_port << "-ThreadKeep ReOpen Failed";
            }
        }
    }

    LOG(WARNING) << local->_port << "-ThreadKeep STOP";
    return 0;
}
