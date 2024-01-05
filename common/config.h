//
// Created by lining on 2024/1/4.
//

#ifndef _CONFIG_H
#define _CONFIG_H

#include <string>
#include <vector>
#include <stdint.h>
#include <mutex>
#include "kafka/KafkaConsumer.h"

using namespace std;

typedef struct {
    int type;//0：未启用 1：kafka 2 ：tcp 3：serial
    int port;
    string kafkaBrokers = "13.145.180.179:9092,13.145.180.193:9092,13.145.180.213:9092";
    string kafkaTopic_c = "cross_phaseStatus";
} ConfSignalLight;


typedef struct {
    vector<string> msgType;

    int summaryFs = 10;
    int thresholdReconnect = 5;//多久没回复信息就重连,单位s
    bool isUseThresholdReconnect = true;

    string eocConfPath;
    string iniPath;

    string roadName;

    ConfSignalLight confSignalLight;
} LocalConfig;

extern LocalConfig localConfig;

/**
 *  获取配置文件
 * @param path
 * @return
 */
int getConfFromINI(string path);

bool isShowMsgType(string msgType);

extern mutex conns_mutex;
extern vector<void *> conns;

extern KafkaConsumer *kafkaConsumer;

#endif //_CONFIG_H
