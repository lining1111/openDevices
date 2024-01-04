//
// Created by lining on 2023/12/13.
//

#include "KafkaConsumer.h"
#include "KafkaCom.h"
#include <stdlib.h>
#include <uuid/uuid.h>

KafkaConsumer::KafkaConsumer(string brokers, string topic, string crossId)
        : _brokers(brokers), _topic(topic), _crossId(crossId) {
    _group_id = "RV" + crossId;
    char *endptr;
    _crossId_c = (uint8_t) strtol(_crossId.substr(_crossId.length() - 3).c_str(), &endptr, 10);
    LOG(WARNING) << "kafka group_id:" << _group_id << ",crossId:" << to_string(_crossId_c);
}

KafkaConsumer::~KafkaConsumer() {
    _isInit = false;
    if (_consumer != nullptr) {
        _consumer->close();
        delete _consumer;
    }
}

int KafkaConsumer::init() {
    //创建 Kafka 配置
    _conf = RdKafka::Conf::create(RdKafka::Conf::CONF_GLOBAL);
    _conf->set("bootstrap.servers", _brokers, errstr);
    _conf->set("group.id", _group_id, errstr);

    _tconf = RdKafka::Conf::create(RdKafka::Conf::CONF_TOPIC);
    _event_cb = std::make_shared<KafkaEventCb>();
    _conf->set("event_cb", _event_cb.get(), errstr);
    _consumer = RdKafka::KafkaConsumer::create(_conf, errstr);

    if (_consumer == nullptr) {
        LOG(ERROR) << "kafka fail to  create consumer:" << errstr;
        return -1;
    }
    _isInit = true;
    return 0;
}

void KafkaConsumer::startBusiness() {
    if (!_isInit) {
        LOG(ERROR) << "kafka not init";
        return;
    }
    _isRun = true;
    LOG(WARNING) << "kafka " << this->_group_id << " start business";
    isLocalThreadRun = true;
    future_consume = std::async(std::launch::async, ThreadConsume, this);
}

void KafkaConsumer::stopBusiness() {
    _isRun = false;

    if (isLocalThreadRun) {
        isLocalThreadRun = false;
        try {
            future_consume.wait();
        } catch (exception &e) {
            LOG(ERROR) << e.what();
        }

    }
    LOG(WARNING) << "kafka " << this->_group_id << " stop business";
}

int KafkaConsumer::ThreadConsume(KafkaConsumer *local) {
    LOG(WARNING) << "kafka " << local->_group_id << " thread consume start";
    vector <string> topics = {local->_topic};
    RdKafka::ErrorCode err = local->_consumer->subscribe(topics);
    if (err != RdKafka::ERR_NO_ERROR) {
        LOG(ERROR) << "kafka failed to subscribe:" << RdKafka::err2str(err);
        return -1;
    }

    while (local->_isRun) {
        RdKafka::Message *msg = local->_consumer->consume(1000 * 20);
        switch (msg->err()) {
            case RdKafka::ERR_NO_ERROR: {
                LOG(INFO) << "kafka msg len:" << msg->len();
                uint8_t *buffer = nullptr;
                buffer = new uint8_t[msg->len()];
                memcpy(buffer, msg->payload(), msg->len());
                //判断信息的字节长度 TabStageWithHeader
//                LOG(INFO) << "kafka head len:" << sizeof(TabStageFrameHeader);
                //至少保证一个头的长度
                if (msg->len() >= sizeof(TabStageFrameHeader)) {
                    //先取下头看看数据类型
                    int pos = 0;
                    int remain = msg->len();
                    TabStageFrameHeader head;
                    memcpy(&head, buffer, sizeof(TabStageFrameHeader));
                    pos += sizeof(TabStageFrameHeader);
                    remain -= sizeof(TabStageFrameHeader);
                    //通过头判断数据类型
                    switch (head.NoTab) {
                        case 4: {
                            if (remain >= sizeof(TabStage)) {
                                //长度够取信息
                                TabStage tabStage;
                                memcpy(&tabStage, buffer + pos, sizeof(TabStage));
                                pos += sizeof(TabStage);
                                remain -= sizeof(TabStage);
                                //判断信息的路口号和当前的路口号是否一致
                                if (local->_crossId_c == tabStage.NoJunc) {
                                    LOG(INFO) << "kafka msg:"
                                              << "区域号:" << to_string(tabStage.NoArea)
                                              << ",路口号:" << to_string(tabStage.NoJunc)
                                              << ",上一相位号:" << to_string(tabStage.NoOldStage)
                                              << ",上一相位长(秒):" << to_string(tabStage.LenOldStage)
                                              << ",当前相位号:" << to_string(tabStage.NoNewStage)
                                              << ",当前相位长:" << to_string(tabStage.LenNewStage)
                                              << ",当前相位名:" << string(tabStage.NewStageName);
                                    //TODO 将数据插入Data
                                    auto *data = Data::instance();
//                                    auto dataUnit = data->dataUnitCrossStageData;
//
//                                    CrossStageData item;
//                                    uuid_t uuid;
//                                    char uuid_str[37];
//                                    memset(uuid_str, 0, 37);
//                                    uuid_generate_time(uuid);
//                                    uuid_unparse(uuid, uuid_str);
//                                    item.oprNum = string(uuid_str);
//                                    item.crossID = data->plateId;
//                                    item.hardCode = data->matrixNo;
//                                    item.timestamp = msg->timestamp().timestamp;
//                                    item.lastStage = tabStage.NoOldStage;
//                                    item.lastStageDuration = tabStage.LenOldStage;
//                                    item.curStage = tabStage.NoNewStage;
//                                    item.curStageDuration = tabStage.LenNewStage;
//                                    std::unique_lock <std::mutex> lock(data->mtx_dataUnitCrossStageData);
//                                    if (!dataUnit.empty()) {
//                                        dataUnit.erase(dataUnit.begin());
//                                    }
//                                    dataUnit.push_back(item);
                                } else {
                                    LOG(INFO) << "kafka msg:"
                                              << ",路口号:" << to_string(tabStage.NoJunc)
                                              << ",not match:" << to_string(local->_crossId_c);
                                }
                            } else {
                                LOG(ERROR) << "kafka msg tab len no enough:"
                                           << to_string(head.NoTab) << ":" << msg->len();
                            }
                        }
                            break;
                        default : {
                            LOG(INFO) << "kafka msg no care:" << to_string(head.NoTab) << ":" << msg->len();
                        }
                            break;
                    }
                } else {
                    LOG(ERROR) << "kafka msg len no enough:" << msg->len();
                }
                delete[]buffer;
            }
                break;
            default : {
                LOG(ERROR) << "kafka consume error:" << msg->errstr();
            }
        }

    }


    LOG(WARNING) << "kafka " << local->_group_id << " thread consume end";
    return 0;
}
