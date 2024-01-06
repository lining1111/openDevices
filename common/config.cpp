//
// Created by lining on 2024/1/4.
//

#include "config.h"

LocalConfig localConfig;

mutex conns_mutex;
vector<void *> conns;

KafkaConsumer *kafkaConsumer = nullptr;

#include "Poco/Util/Application.h"
#include "Poco/Path.h"
#include "Poco/AutoPtr.h"
#include "Poco/Util/IniFileConfiguration.h"

int getConfFromINI(string path) {
    int ret = 0;
    try {
        Poco::AutoPtr<Poco::Util::IniFileConfiguration> pConf(new Poco::Util::IniFileConfiguration(path));
        localConfig.confSignalLight.type = pConf->getInt("signalLight.type", 0);
        localConfig.confSignalLight.port = pConf->getInt("signalLight.port", 35100);
        localConfig.confSignalLight.kafkaBrokers = pConf->getString("signalLight.kafkaBrokers",
                                                                    "13.145.180.179:9092,13.145.180.193:9092,13.145.180.213:9092");
        localConfig.confSignalLight.kafkaTopic_c = pConf->getString("signalLight.kafkaTopic_c",
                                                                    "cross_phaseStatus");
        //roadName
        localConfig.intersectionName = pConf->getString("intersection.name", "");

        ret = 0;
    }
    catch (Poco::Exception &exc) {
        std::cerr << exc.displayText() << std::endl;
        ret = -1;

    }

    return ret;
}

bool isShowMsgType(string msgType) {
    if (localConfig.msgType.empty()) {
        return false;
    } else {
        bool isExist = false;
        for (auto iter: localConfig.msgType) {
            if (iter == msgType) {
                isExist = true;
                break;
            }
        }
        return isExist;
    }
}


