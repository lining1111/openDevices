//
// Created by lining on 2023/12/14.
//

#ifndef RVDATAFUSIONSERVER_KAFKAPRODUCER_H
#define RVDATAFUSIONSERVER_KAFKAPRODUCER_H

#include <string>
#include <iostream>
#include <vector>
#include <algorithm>
#include <future>
#include <thread>
#include "data/Data.h"
#include <librdkafka/rdkafkacpp.h>
#include <glog/logging.h>

using namespace std;

class KafkaProducer {
public:
    string _topic;
    string _brokers;

    RdKafka::Topic *_topic_ptr = nullptr;
    RdKafka::Conf *_conf = nullptr;
    RdKafka::Conf *_tconf = nullptr;
    RdKafka::Producer *_producer = nullptr;

    string errstr;

    vector<char> _notify;

    bool _isInit = false;
    bool _isRun = false;
    bool isLocalThreadRun = false;
    shared_future<int> future_consume;

    KafkaProducer(string brokers, string topic);

    ~KafkaProducer();

    int init();

    void startBusiness();

    void stopBusiness();

    static int ThreadProduce(KafkaProducer *local);

    int produce(const vector<char> &data);

};


#endif //RVDATAFUSIONSERVER_KAFKAPRODUCER_H
