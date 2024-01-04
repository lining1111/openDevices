//
// Created by lining on 2023/8/21.
//

#ifndef RVDATAFUSIONSERVER_TCPSERVER_H
#define RVDATAFUSIONSERVER_TCPSERVER_H

#include "Poco/Net/SocketReactor.h"
#include "Poco/Net/SocketNotification.h"
#include "Poco/Net/SocketConnector.h"
#include "Poco/Net/SocketAcceptor.h"
#include "Poco/Net/StreamSocket.h"
#include "Poco/Net/ServerSocket.h"
#include "Poco/Net/SocketAddress.h"
#include "Poco/Net/NetException.h"
#include "Poco/Observer.h"
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

#include "MyTcpHandler.hpp"

class MyTcpServerHandler : public MyTcpHandler {
public:
    SocketReactor &_reactor;
    char *recvBuf = nullptr;
public:
    MyTcpServerHandler(StreamSocket &socket, SocketReactor &reactor) :
            _reactor(reactor) {
        _socket = socket;
        _peerAddress = socket.peerAddress().toString();
        LOG(WARNING) << "connection from " << _peerAddress << " ...";
        std::unique_lock<std::mutex> lock(conns_mutex);
        conns.push_back(this);
        _reactor.addEventHandler(_socket, Observer<MyTcpServerHandler, ReadableNotification>(*this,
                                                                                             &MyTcpServerHandler::onReadable));
        _reactor.addEventHandler(_socket, NObserver<MyTcpServerHandler, ShutdownNotification>(*this,
                                                                                              &MyTcpServerHandler::onSocketShutdown));
        recvBuf = new char[1024 * 1024];
        startBusiness();
    }

    ~MyTcpServerHandler() {
        LOG(WARNING) << _peerAddress << " disconnected ...";
        stopBusiness();
        _reactor.removeEventHandler(_socket, Observer<MyTcpServerHandler, ReadableNotification>(*this,
                                                                                                &MyTcpServerHandler::onReadable));
        _reactor.removeEventHandler(_socket, NObserver<MyTcpServerHandler, ShutdownNotification>(*this,
                                                                                                 &MyTcpServerHandler::onSocketShutdown));
        delete[]recvBuf;
        std::unique_lock<std::mutex> lock(conns_mutex);
        for (int i = 0; i < conns.size(); i++) {
            auto conn = (MyTcpServerHandler *) conns.at(i);
            if (conn->_peerAddress == _peerAddress) {
                conns.erase(conns.begin() + i);
                LOG(WARNING) << "从数组踢出客户端:" << conn->_peerAddress;
            }
        }
    }

    void onReadable(ReadableNotification *pNf) {
        pNf->release();
        if (rb == nullptr) {
            LOG(ERROR) << _peerAddress << " rb null";
            return;
        }

        bzero(recvBuf, 1024 * 1024);
        int recvLen = (rb->GetWriteLen() < (1024 * 1024)) ? rb->GetWriteLen() : (1024 * 1024);
        try {
            int len = _socket.receiveBytes(recvBuf, recvLen);
            if (len <= 0) {
                LOG(WARNING) << _peerAddress << " receive len <=0";
                delete this;
            } else {
                rb->Write(recvBuf, len);
            }
        }
        catch (Poco::Exception &exc) {
            LOG(WARNING) << exc.what();
            delete this;
        }
    }

    void onSocketShutdown(const AutoPtr<ShutdownNotification> &pNf) {
        pNf->release();
        delete this;
    }

    int SendBase(common::Pkg pkg) {
        int ret = 0;
        //阻塞调用，加锁
        std::unique_lock<std::mutex> lock(*mtx);

        uint8_t *buf_send = new uint8_t[(sizeof(pkg.head) + sizeof(pkg.crc) + pkg.body.length())];
        uint32_t len_send = (sizeof(pkg.head) + sizeof(pkg.crc) + pkg.body.length());
        //pack
        len_send = common::Pack(pkg, buf_send, len_send);
        if (len_send == 0) {
            delete[] buf_send;
            LOG(ERROR) << "pack error";
            return -1;
        }
        try {
            auto len = _socket.sendBytes(buf_send, len_send);
            VLOG(2) << _peerAddress << " send len:" << len << " len_send:" << len_send;
            if (len < 0) {
                LOG(ERROR) << _peerAddress << " send len < 0";
                delete this;
                ret = -2;
            } else if (len != len_send) {
                LOG(ERROR) << _peerAddress << " send len !=len_send";
                delete this;
                ret = -2;
            }
        }
        catch (Poco::Exception &exc) {
            LOG(ERROR) << _peerAddress << " send error:" << exc.code() << exc.displayText();
            if (exc.code() != POCO_ETIMEDOUT && exc.code() != POCO_EWOULDBLOCK && exc.code() != POCO_EAGAIN) {
                delete this;
                ret = -2;
            } else {
                ret = -3;
            }
        }
        //记录发送时间
        if (this->timeSend == 0) {
            this->timeRecv = std::chrono::duration_cast<std::chrono::milliseconds>(
                    std::chrono::system_clock::now().time_since_epoch()).count();
        }

        this->timeSend = std::chrono::duration_cast<std::chrono::milliseconds>(
                std::chrono::system_clock::now().time_since_epoch()).count();

//        //检验下回复时间和发送时间的差，是否大于阈值，大于就重连
//        if (localConfig.isUseThresholdReconnect) {
//            if (std::abs((long long) this->timeRecv - (long long) this->timeSend) >=
//                (1000 * localConfig.thresholdReconnect)) {
//                LOG(WARNING) << "接收和发送时间差大于阈值，需要重连，ip:" << this->_peerAddress
//                             << " timeRecv:" << this->timeRecv << " timeSend:" << this->timeSend;
//                this->isNeedReconnect = true;
//            }
//        }

        delete[] buf_send;
        return ret;
    }

    int Send(char *buf_send, int len_send) {
        int ret = 0;
        //阻塞调用，加锁
        std::unique_lock<std::mutex> lock(*mtx);

        try {
            auto len = _socket.sendBytes(buf_send, len_send);
            VLOG(2) << _peerAddress << " send len:" << len << " len_send:" << len_send;
            if (len < 0) {
                LOG(ERROR) << _peerAddress << " send len < 0";
                delete this;
                ret = -2;
            } else if (len != len_send) {
                LOG(ERROR) << _peerAddress << " send len !=len_send";
                delete this;
                ret = -2;
            }
        }
        catch (Poco::Exception &exc) {
            LOG(ERROR) << _peerAddress << " send error:" << exc.code() << exc.displayText();
            if (exc.code() != POCO_ETIMEDOUT && exc.code() != POCO_EWOULDBLOCK && exc.code() != POCO_EAGAIN) {
                delete this;
                ret = -2;
            } else {
                ret = -3;
            }
        }

        //记录发送时间
        if (this->timeSend == 0) {
            this->timeRecv = std::chrono::duration_cast<std::chrono::milliseconds>(
                    std::chrono::system_clock::now().time_since_epoch()).count();
        }

        this->timeSend = std::chrono::duration_cast<std::chrono::milliseconds>(
                std::chrono::system_clock::now().time_since_epoch()).count();

//        //检验下回复时间和发送时间的差，是否大于阈值，大于就重连
//        if (localConfig.isUseThresholdReconnect) {
//            if (std::abs((long long) this->timeRecv - (long long) this->timeSend) >=
//                (1000 * localConfig.thresholdReconnect)) {
//                this->isNeedReconnect = true;
//                LOG(WARNING) << "接收和发送时间差大于阈值，需要重连，ip:" << this->_peerAddress
//                             << " timeRecv:" << this->timeRecv << " timeSend:" << this->timeSend;
//            }
//        }

        delete[] buf_send;
        return ret;
    }
};

class MyTcpServer {
public:
    int _port;
    Poco::Net::ServerSocket _s;
    Poco::Net::SocketReactor _reactor;
    Poco::Thread _t;
    Poco::Net::SocketAcceptor<MyTcpServerHandler> *_acceptor = nullptr;
    bool isListen = false;
public:
    MyTcpServer(int port) : _port(port) {

    }

    ~MyTcpServer() {
        delete _acceptor;
    }

    int Open() {
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
        _acceptor = new Poco::Net::SocketAcceptor<MyTcpServerHandler>(_s, _reactor);
        isListen = true;
        return 0;
    }

    int ReOpen() {
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
        _acceptor = new Poco::Net::SocketAcceptor<MyTcpServerHandler>(_s, _reactor);
        isListen = true;
        return 0;
    }


    int Run() {
        //Starting TCP Server
        _t.start(_reactor);
        LOG(WARNING) << _port << "-Server Started";
        LOG(WARNING) << _port << "-Ready To Accept the connections";
        return 0;
    }

};


#endif //RVDATAFUSIONSERVER_TCPSERVER_H
