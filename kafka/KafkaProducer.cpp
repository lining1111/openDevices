//
// Created by lining on 2023/12/14.
//

#include "KafkaProducer.h"
#include <stdlib.h>

KafkaProducer::KafkaProducer(string brokers, string topic)
        : _brokers(brokers), _topic(topic) {
}

KafkaProducer::~KafkaProducer() {
    _isInit = false;
    delete _conf;
    delete _tconf;
    delete _topic_ptr;
    delete _producer;
    RdKafka::wait_destroyed(5000);
}

int KafkaProducer::init() {
    //创建 Kafka 配置
    _conf = RdKafka::Conf::create(RdKafka::Conf::CONF_GLOBAL);
    _tconf = RdKafka::Conf::create(RdKafka::Conf::CONF_TOPIC);

    _conf->set("message.max.bytes", "10240000", errstr);
    _conf->set("replica.fetch.max.bytes", "20485760", errstr);
    _conf->set("bootstrap.servers", _brokers, errstr);


    _producer = RdKafka::Producer::create(_conf, errstr);

    if (_producer == nullptr) {
        LOG(ERROR) << "kafka fail to  create produce:" << errstr;
        return -1;
    }

    _topic_ptr = RdKafka::Topic::create(_producer, _topic, _tconf, errstr);
    if (_topic_ptr == nullptr) {
        LOG(ERROR) << "kafka fail to  create produce:" << errstr;
        return -1;
    }

    _isInit = true;
    return 0;
}

void KafkaProducer::startBusiness() {
    if (!_isInit) {
        LOG(ERROR) << "kafka not init";
        return;
    }
    _isRun = true;
    LOG(WARNING) << "kafka " << this->_brokers << " start business";
    isLocalThreadRun = true;
    future_consume = std::async(std::launch::async, ThreadProduce, this);
}

void KafkaProducer::stopBusiness() {
    _isRun = false;

    if (isLocalThreadRun) {
        isLocalThreadRun = false;
        try {
            future_consume.wait();
        } catch (exception &e) {
            LOG(ERROR) << e.what();
        }

    }
    LOG(WARNING) << "kafka " << this->_brokers << " stop business";
}

int KafkaProducer::ThreadProduce(KafkaProducer *local) {
    LOG(WARNING) << "kafka " << local->_producer << " thread produce start";

    while (local->_isRun) {
        RdKafka::ErrorCode err = local->_producer->produce(local->_topic_ptr, RdKafka::Topic::PARTITION_UA,
                                                           RdKafka::Producer::RK_MSG_COPY,
                                                           (void*)local->_notify.data(),local->_notify.size(),
                                                           nullptr, nullptr);
        if (err != RdKafka::ERR_NO_ERROR) {
            LOG(ERROR) << "kafka failed to produce:" << RdKafka::err2str(err);
        }
    }


    LOG(WARNING) << "kafka " << local->_brokers << " thread produce end";
    return 0;
}

int KafkaProducer::produce(const vector<char> &data){
    RdKafka::ErrorCode err = _producer->produce(_topic_ptr, RdKafka::Topic::PARTITION_UA,
                                                       RdKafka::Producer::RK_MSG_COPY,
                                                       (void*)data.data(),data.size(),
                                                       nullptr, nullptr);
    if (err != RdKafka::ERR_NO_ERROR) {
        LOG(ERROR) << "kafka failed to produce:" << RdKafka::err2str(err);
    }
    return err;
}
