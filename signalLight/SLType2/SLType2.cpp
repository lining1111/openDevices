//
// Created by lining on 2024/1/4.
//

#include "SLType2.h"
#include <fmt/format.h>
#include <fmt/ranges.h>

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
    content = fmt::format("{}", v_buf);
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
        }
        LOG(WARNING) << local->_peerAddress << " ThreadProcessPkg end";
        return 0;
    }
}


SLType2::SLType2(int port) : _port(port) {

}

SLType2::SLType2() {

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

