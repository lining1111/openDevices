//
// Created by lining on 2024/1/4.
//

#include "Data.h"
#include <sqlite3.h>
#include <algorithm>
#include <glog/logging.h>
#include "common/config.h"
#include "os/os.h"
#include "myTcp/MyTcpServer.hpp"

Data *Data::m_pInstance = nullptr;

Data *Data::instance() {
    if (m_pInstance == nullptr) {
        m_pInstance = new Data();

        std::unique_lock<std::mutex> lck(m_pInstance->mtx);
        //1读取本地属性
        m_pInstance->getMatrixNo();
        m_pInstance->getPlatId();
        //2初始化数据
        m_pInstance->initSignalLightStates();

        m_pInstance->isRun = true;
    }
    return m_pInstance;
}


int Data::getMatrixNo() {
    //打开数据库
    sqlite3 *db;
    string dbName;
#ifdef aarch64
    dbName = "/home/nvidianx/bin/CLParking.db";
#else
    dbName = "CLParking.db";
#endif
    //open
    int rc = sqlite3_open(dbName.c_str(), &db);
    if (rc != SQLITE_OK) {
        LOG(ERROR) << "sqlite open fail db:" << dbName;
        sqlite3_close(db);
        return -1;
    }

    const char *sql = "select UName from CL_ParkingArea where ID=(select max(ID) from CL_ParkingArea)";
    char **result, *errmsg;
    int nrow, ncolumn;
    string columnName;
    rc = sqlite3_get_table(db, sql, &result, &nrow, &ncolumn, &errmsg);
    if (rc != SQLITE_OK) {
        LOG(ERROR) << "sqlite err:" << errmsg;
        sqlite3_free(errmsg);
        return -1;
    }
    for (int m = 0; m < nrow; m++) {
        for (int n = 0; n < ncolumn; n++) {
            columnName = string(result[n]);
            if (columnName == "UName") {
                matrixNo = STR(result[ncolumn + n + m * nrow]);
                break;
            }
        }
    }
    //处理下sn字符串中间可能带-的情况
    matrixNo.erase(std::remove(matrixNo.begin(), matrixNo.end(), '-'), matrixNo.end());

    LOG(WARNING) << "sn:" << matrixNo;
    sqlite3_free_table(result);
    sqlite3_close(db);
    return 0;
}

int Data::getPlatId() {
    //打开数据库
    sqlite3 *db;
    string dbName;
    dbName = localConfig.eocConfPath;
    //open
    int rc = sqlite3_open(dbName.c_str(), &db);
    if (rc != SQLITE_OK) {
        LOG(ERROR) << "sqlite open fail db:" << dbName;
        sqlite3_close(db);
        return -1;
    }

    const char *sql = "select PlatId from belong_intersection order by id desc limit 1";
    char **result, *errmsg;
    int nrow, ncolumn;
    string columnName;
    rc = sqlite3_get_table(db, sql, &result, &nrow, &ncolumn, &errmsg);
    if (rc != SQLITE_OK) {
        LOG(ERROR) << "sqlite err:" << errmsg;
        sqlite3_free(errmsg);
        return -1;
    }
    for (int m = 0; m < nrow; m++) {
        for (int n = 0; n < ncolumn; n++) {
            columnName = string(result[n]);
            if (columnName == "PlatId") {
                plateId = STR(result[ncolumn + n + m * nrow]);
                break;
            }
        }
    }
    LOG(WARNING) << "plateId:" << plateId;
    sqlite3_free_table(result);
    sqlite3_close(db);
    return 0;
}

void Data::initSignalLightStates() {
    signalLightStates.clear();
    SignalLightState item;
    item.timestamp = os::getTimestampMs();
    item.crossID = plateId;
    item.hardCode = matrixNo;
    for (int i = 0; i < 8; i++) {
        SignalLightState_lstIntersections_item item1;
        item1.matrixNo = to_string(i);
        item1.left = -1;//未知
        item1.right = -1;
        item1.straight = -1;
        item.lstIntersections.push_back(item1);
    }
    //生成新旧两个
    for (int i = 0; i < 2; i++) {
        signalLightStates.push_back(item);
    }
}


int Data::broadcastSignalLightStates() {
    //遍历接入本地server的客户端，将最新的灯态广播出去
    SignalLightState msgSend;
    std::unique_lock<std::mutex> lock(mtx_signalLightStates);
    if (signalLightStates.empty()) {
        msgSend.crossID = plateId;
        msgSend.hardCode = matrixNo;
        msgSend.timestamp = os::getTimestampMs();
    } else {
        msgSend = signalLightStates.back();
    }

    uint32_t deviceNo = stoi(matrixNo.substr(0, 10));
    Pkg pkg;
    msgSend.PkgWithoutCRC(sn_SignalLightState, deviceNo, pkg);
    sn_SignalLightState++;
    lock.unlock();

    std::unique_lock<std::mutex> lock1(conns_mutex);
    for (auto conn: conns) {
        if (conn != nullptr) {
            auto local = (MyTcpServerHandler *) conn;
            string ip = local->_peerAddress;

            string msgType = "SignalLightState";

            if (!local->SendBase(pkg)) {
                LOG_IF(INFO, isShowMsgType(msgType)) << "client ip:" << ip << " " << msgType << ",发送消息失败";
            } else {
                LOG_IF(INFO, isShowMsgType(msgType)) << "client ip:" << ip << " " << msgType << ",发送消息成功，"
                                                     << "hardCode:" << msgSend.hardCode << " crossID:"
                                                     << msgSend.crossID
                                                     << "timestamp:" << (uint64_t) msgSend.timestamp;
            }
        }
    }

    return 0;
}
