//
// Created by lining on 2024/1/5.
//

#include <arpa/inet.h>
#include <linux/socket.h>
#include <cstring>
#include <unistd.h>
#include <iostream>
#include <sys/time.h>
#include "common/CRC.h"
#include "common/common.h"
#include <gflags/gflags.h>
#include <fstream>
#include <chrono>
#include <iomanip>
#include "os/timeTask.hpp"
#include <uuid/uuid.h>
#include "os/os.h"

using namespace std;
using namespace common;

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

DEFINE_string(cloudIp, "127.0.0.1", "云端ip，默认127.0.0.1");
DEFINE_int32(cloudPort, 9002, "云端端口号，默认9002");

int main(int argc, char **argv) {


    SignalLightState msgSend;

    msgSend.hardCode = "123456";
    msgSend.timestamp = os::getTimestampMs();

    uint32_t deviceNo = 0x12345678;
    Pkg pkg;
    msgSend.PkgWithoutCRC(1, deviceNo, pkg);

    uint8_t *buf_send = new uint8_t[(sizeof(pkg.head) + sizeof(pkg.crc) + pkg.body.length())];
    uint32_t len_send = (sizeof(pkg.head) + sizeof(pkg.crc) + pkg.body.length());
    //pack
    len_send = common::Pack(pkg, buf_send, len_send);
    if (len_send == 0) {
        delete[] buf_send;
        return -1;
    }

    //接入服务器
    string server_ip = FLAGS_cloudIp;
    int server_port = FLAGS_cloudPort;
    StreamSocket _socket;
    std::string _peerAddress;

    SocketAddress sa(server_ip, server_port);
    try {
        Poco::Timespan ts(1000 * 1000);
        _socket.connect(sa, ts);
    } catch (ConnectionRefusedException &) {
        cout << server_ip << ":" << server_port << " connect refuse" << endl;
        return -1;
    }
    catch (TimeoutException &) {
        cout << server_ip << ":" << server_port << " connect time out" << endl;
        return -1;
    }
    catch (NetException &) {
        cout << server_ip << ":" << server_port << " net exception" << endl;
        return -1;
    }
    catch (Poco::IOException &) {
        cout << server_ip << ":" << server_port << " io exception" << endl;
        return -1;
    }


    bool isExit = false;

    while (!isExit) {
        string user;

        cout << "please enter(q:quit):" << endl;
        cin >> user;

        if (user == "q") {
            isExit = true;
            continue;
        } else {
            //发送问询
            _socket.sendBytes(buf_send, len_send);
            //接收应答
            char buf_recv[1024] = {0};
            int len_recv = _socket.receiveBytes(buf_recv, 1024);
            //解包
            Pkg pkgRec;
            if (common::Unpack((uint8_t *) buf_recv, len_recv, pkgRec) == 0) {
                cout << "get:" << pkgRec.body << endl;
            }
        }

    }

    delete[] buf_send;
    return 0;
}