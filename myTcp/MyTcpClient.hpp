//
// Created by lining on 2023/8/21.
//

#ifndef RVDATAFUSIONSERVER_MYTCPCLIENT_H
#define RVDATAFUSIONSERVER_MYTCPCLIENT_H

#include "Poco/Net/SocketReactor.h"
#include "Poco/Net/SocketNotification.h"
#include "Poco/Net/SocketConnector.h"
#include "Poco/Net/SocketAcceptor.h"
#include "Poco/Net/StreamSocket.h"
#include "Poco/Net/ServerSocket.h"
#include "Poco/Net/SocketAddress.h"
#include "Poco/Net/NetException.h"
#include <Poco/Exception.h>
#include "Poco/Observer.h"
#include "Poco/NObserver.h"
#include <glog/logging.h>
#include <iostream>

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
using Poco::Net::ConnectionRefusedException;
using Poco::Net::InvalidSocketException;
using Poco::TimeoutException;

#include "MyTcpHandler.hpp"

class MyTcpClient : public MyTcpHandler {
public:
    string server_ip;
    int server_port;
    bool isNeedReconnect = true;
    char *recvBuf = nullptr;
    std::thread _t;
public:
    MyTcpClient(string serverip, int serverport) :
            server_ip(serverip), server_port(serverport) {
        recvBuf = new char[1024 * 1024];
    }

    ~MyTcpClient() {
        LOG(WARNING) << _peerAddress << " disconnected ...";
        stopBusiness();
        delete[]recvBuf;
    }

    int Open() {
        SocketAddress sa(server_ip, server_port);
        try {
            Poco::Timespan ts(1000 * 1000);
            _socket.connect(sa, ts);
        } catch (ConnectionRefusedException &) {
            LOG(ERROR) << server_ip << ":" << server_port << " connect refuse";
            return -1;
        }
        catch (TimeoutException &) {
            LOG(ERROR) << server_ip << ":" << server_port << " connect time out";
            return -1;
        }
        catch (NetException &) {
            LOG(ERROR) << server_ip << ":" << server_port << " net exception";
            return -1;
        }
        catch (Poco::IOException &) {
            LOG(ERROR) << server_ip << ":" << server_port << " io exception";
            return -1;
        }

        _peerAddress = _socket.peerAddress().toString();
        LOG(WARNING) << "connection to " << _peerAddress << " ...";
        Poco::Timespan ts1(1000 * 100);
        _socket.setSendTimeout(ts1);
        isNeedReconnect = false;
        timeSend = 0;
        timeRecv = 0;
        return 0;
    }

    int Reconnect() {
        _socket.close();
        SocketAddress sa(server_ip, server_port);
        try {
            Poco::Timespan ts(1000 * 1000);
            _socket.connect(sa, ts);
        } catch (ConnectionRefusedException &) {
            LOG(ERROR) << server_ip << ":" << server_port << " connect refuse";
            return -1;
        }
        catch (TimeoutException &) {
            LOG(ERROR) << server_ip << ":" << server_port << " connect time out";
            return -1;
        }
        catch (NetException &) {
            LOG(ERROR) << server_ip << ":" << server_port << " net exception";
            return -1;
        }
        catch (Poco::IOException &) {
            LOG(ERROR) << server_ip << ":" << server_port << " io exception";
            return -1;
        }

        _peerAddress = _socket.peerAddress().toString();
        LOG(WARNING) << "reconnection to " << _peerAddress << " ...";
        Poco::Timespan ts1(1000 * 100);
        _socket.setSendTimeout(ts1);
        isNeedReconnect = false;
        timeSend = 0;
        timeRecv = 0;
        return 0;
    }

    int Run() {
        startBusiness();
        _t = std::thread([this]() {
            LOG(WARNING) << "_t start";
            while (this->_isRun) {
                usleep(10);
                if (!this->isNeedReconnect) {
                    if (rb == nullptr) {
                        LOG(ERROR) << _peerAddress << " rb null";
                        continue;
                    }
                    if (_socket.available() <= 0) {
                        continue;
                    }
                    bzero(recvBuf, 1024 * 1024);
                    int recvLen = (rb->GetWriteLen() < (1024 * 1024)) ? rb->GetWriteLen() : (1024 * 1024);
                    try {
                        int len = _socket.receiveBytes(recvBuf, recvLen);
                        if (len < 0) {
                            LOG(ERROR) << server_ip << ":" << server_port << " receive len <0";
                            isNeedReconnect = true;
                        } else if (len > 0) {
                            rb->Write(recvBuf, len);
                        }
                    }
                    catch (Poco::Exception &exc) {
                        LOG(ERROR) << server_ip << ":" << server_port << " receive error:" << exc.code()
                                   << exc.displayText();
                        if (exc.code() != POCO_ETIMEDOUT && exc.code() != POCO_EWOULDBLOCK &&
                            exc.code() != POCO_EAGAIN) {
                            isNeedReconnect = true;
                        }
                    }
                }
            }
            LOG(WARNING) << "_t end";
        });
        _t.detach();
        return 0;
    }

    int SendBase(common::Pkg pkg) {
        int ret = 0;
        //阻塞调用，加锁
        std::unique_lock<std::mutex> lock(*mtx);
        if (isNeedReconnect) {
            return -1;
        }

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
                isNeedReconnect = true;
                ret = -2;
            } else if (len != len_send) {
                LOG(ERROR) << _peerAddress << " send len !=len_send";
                isNeedReconnect = true;
                ret = -2;
            }
        }
        catch (Poco::Exception &exc) {
            LOG(ERROR) << _peerAddress << " send error:" << exc.code() << exc.displayText();
            if (exc.code() != POCO_ETIMEDOUT && exc.code() != POCO_EWOULDBLOCK && exc.code() != POCO_EAGAIN) {
                isNeedReconnect = true;
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

        //检验下回复时间和发送时间的差，是否大于阈值，大于就重连
        if (localConfig.isUseThresholdReconnect) {
            if (std::abs((long long) this->timeRecv - (long long) this->timeSend) >=
                (1000 * localConfig.thresholdReconnect)) {
                LOG(WARNING) << "接收和发送时间差大于阈值，需要重连，ip:" << this->_peerAddress
                             << " timeRecv:" << this->timeRecv << " timeSend:" << this->timeSend;
                this->isNeedReconnect = true;
            }
        }

        delete[] buf_send;
        return ret;
    }

    int Send(char *buf_send, int len_send) {
        int ret = 0;
        //阻塞调用，加锁
        std::unique_lock<std::mutex> lock(*mtx);
        if (isNeedReconnect) {
            return -1;
        }
        try {
            auto len = _socket.sendBytes(buf_send, len_send);
            VLOG(2) << _peerAddress << " send len:" << len << " len_send:" << len_send;
            if (len < 0) {
                LOG(ERROR) << _peerAddress << " send len < 0";
                isNeedReconnect = true;
                ret = -2;
            } else if (len != len_send) {
                LOG(ERROR) << _peerAddress << " send len !=len_send";
                isNeedReconnect = true;
                ret = -2;
            }
        }
        catch (Poco::Exception &exc) {
            LOG(ERROR) << _peerAddress << " send error:" << exc.code() << exc.displayText();
            if (exc.code() != POCO_ETIMEDOUT && exc.code() != POCO_EWOULDBLOCK && exc.code() != POCO_EAGAIN) {
                isNeedReconnect = true;
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

        //检验下回复时间和发送时间的差，是否大于阈值，大于就重连
        if (localConfig.isUseThresholdReconnect) {
            if (std::abs((long long) this->timeRecv - (long long) this->timeSend) >=
                (1000 * localConfig.thresholdReconnect)) {
                this->isNeedReconnect = true;
                LOG(WARNING) << "接收和发送时间差大于阈值，需要重连，ip:" << this->_peerAddress
                             << " timeRecv:" << this->timeRecv << " timeSend:" << this->timeSend;
            }
        }

        return ret;
    }
};

#endif //RVDATAFUSIONSERVER_MYTCPCLIENT_H
