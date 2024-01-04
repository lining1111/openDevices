//
// Created by lining on 2023/12/13.
//

#ifndef RVDATAFUSIONSERVER_KAFKACONSUMER_H
#define RVDATAFUSIONSERVER_KAFKACONSUMER_H

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

//路口号的后3位
// std::string brokers = "13.145.180.179:9092,13.145.180.193:9092,13.145.180.213:9092";
// std::string topic = "cross_phaseStatus";

class KafkaEventCb : public RdKafka::EventCb {
public:
    void event_cb(RdKafka::Event &event) {
        switch (event.type()) {
            case RdKafka::Event::EVENT_ERROR:
                LOG(ERROR) << "kafka " << RdKafka::err2str(event.err()).c_str();
                break;
            case RdKafka::Event::EVENT_LOG:
                LOG(INFO) << "kafka log:" << event.str();
                break;
            default:
                LOG(INFO) << "kafka event:" << event.type() << " (" << RdKafka::err2str(event.err()) << ")";
                break;
        }
    }
};


class KafkaConsumer {
public:
    string _topic;
    string _brokers;
    string _group_id;//设置为RV+路口号

    RdKafka::Conf *_conf = nullptr;
    RdKafka::Conf *_tconf = nullptr;
    RdKafka::KafkaConsumer *_consumer = nullptr;

    string _crossId;
    uint8_t _crossId_c;
    string errstr;

    std::shared_ptr<KafkaEventCb> _event_cb;

    bool _isInit = false;
    bool _isRun = false;
    bool isLocalThreadRun = false;
    shared_future<int> future_consume;

    KafkaConsumer(string brokers, string topic, string crossId);

    ~KafkaConsumer();

    int init();

    void startBusiness();

    void stopBusiness();

    static int ThreadConsume(KafkaConsumer *local);

};


#endif //RVDATAFUSIONSERVER_KAFKACONSUMER_H
