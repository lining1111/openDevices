//
// Created by lining on 2024/1/4.
//

#ifndef _DATA_H
#define _DATA_H

#include "os/nonCopyable.hpp"
#include "common/common.h"
#include <mutex>
#include <string>
#include <vector>
using namespace std;
using namespace common;

class Data :public NonCopyable {
public:
    mutex mtx;
    static Data *m_pInstance;
    bool isRun = false;

    string db = "CLParking.db";
    string matrixNo = "0123456789";
    string plateId;
public:
    mutex mtx_signalLightStates;
    vector<SignalLightState> signalLightStates;//最多2个，0旧的，1新的
    uint64_t sn_SignalLightState = 0;

public:
    static Data *instance();

    ~Data() {
        isRun = false;
    }

    int broadcastSignalLightStates();

private:
    int getMatrixNo();

    int getPlatId();
};


#endif //_DATA_H
