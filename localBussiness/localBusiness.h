//
// Created by lining on 10/10/22.
//

#ifndef _LOCALBUSINESS_H
#define _LOCALBUSINESS_H

//#include <server/FusionServer.h>
//#include <client/FusionClient.h>
#include "myTcp/MyTcpClient.hpp"
#include "myTcp/MyTcpServer.hpp"

#include <map>
#include <functional>
#include "os/nonCopyable.hpp"
#include "os/timeTask.hpp"

class LocalBusiness : public NonCopyable {
public:
    std::mutex mtx;
    static LocalBusiness *m_pInstance;

    bool isRun = false;

    std::map<string, MyTcpServer *> serverList;
    std::map<string, MyTcpClient *> clientList;
public:
    static LocalBusiness *instance();

    ~LocalBusiness(){
        StopTimerTaskAll();
        isRun = false;
        for (auto iter = clientList.begin(); iter != clientList.end();) {
            delete iter->second;
            iter = clientList.erase(iter);
        }
        for (auto iter = serverList.begin(); iter != serverList.end();) {
            delete iter->second;
            iter = serverList.erase(iter);
        }
    };


    void AddServer(string name, int port);

    void AddClient(string name, string cloudIp, int cloudPort);

    void Run();

public:
    os::Timer timerKeep;

    void StartTimerTask();

    void StopTimerTaskAll();

private:
    /**
    * 查看服务端和客户端状态，并执行断线重连
    * @param p
    */
    static void Task_Keep(void *p);

};


#endif //_LOCALBUSINESS_H
