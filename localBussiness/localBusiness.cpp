//
// Created by lining on 11/22/22.
//

#include <functional>
#include "localBusiness.h"
#include <arpa/inet.h>
#include <fstream>
#include <iomanip>
#include <sstream>
#include <sys/stat.h>
#include <sys/types.h>
#include <glog/logging.h>
#include <uuid/uuid.h>
#include "data/Data.h"
#include "common/config.h"

static int saveCountMax = 0;

LocalBusiness *LocalBusiness::m_pInstance = nullptr;

LocalBusiness *LocalBusiness::instance() {
    if (m_pInstance == nullptr) {
        m_pInstance = new LocalBusiness();
    }
    return m_pInstance;
}

void LocalBusiness::AddServer(string name, int port) {
    MyTcpServer *server = new MyTcpServer(port);
    serverList.insert(make_pair(name, server));
}

void LocalBusiness::AddClient(string name, string cloudIp, int cloudPort) {
    MyTcpClient *client = new MyTcpClient(cloudIp, cloudPort);//端口号和ip依实际情况而变
    clientList.insert(make_pair(name, client));
}


void LocalBusiness::Run() {
    isRun = true;
    for (auto &iter: serverList) {
        if (iter.second->Open() == 0) {
//            iter.second->Run();
        }
        iter.second->Run();
        sleep(5);
    }
    for (auto &iter: clientList) {
        if (iter.second->Open() == 0) {
//            iter.second->Run();
        }
        iter.second->Run();
        sleep(5);
    }

    StartTimerTask();
}

void LocalBusiness::StartTimerTask() {
    timerKeep.start(1000 * 3, std::bind(Task_Keep, this));
}


void LocalBusiness::StopTimerTaskAll() {
    timerKeep.stop();
}

void LocalBusiness::Task_Keep(void *p) {
    if (p == nullptr) {
        return;
    }
//    LOG(INFO) << __FUNCTION__ << " START";
    auto local = (LocalBusiness *) p;

    if (local->serverList.empty() || local->clientList.empty()) {
        return;
    }

    if (local->isRun) {
        for (auto &iter: local->serverList) {
            if (!iter.second->isListen) {
                iter.second->ReOpen();
                if (iter.second->isListen) {
//                    iter.second->Run();
                    LOG(WARNING) << "服务端:" << iter.first << " port:" << iter.second->_port << " 重启";
                } else {
                    LOG(WARNING) << "服务端:" << iter.first << " port:" << iter.second->_port << " 重启失败";
                }
            }
        }

        for (auto &iter: local->clientList) {
            if (iter.second->isNeedReconnect) {
                iter.second->Reconnect();
                if (!iter.second->isNeedReconnect) {
//                    iter.second->Run();
                    LOG(WARNING) << "客户端:" << iter.first <<
                                 " " << iter.second->server_ip << "_" << iter.second->server_port << " 重启";
                } else {
                    LOG(WARNING) << "客户端:" << iter.first <<
                                 " " << iter.second->server_ip << "_" << iter.second->server_port << " 重启失败";
                }
            }
        }
    }
}

