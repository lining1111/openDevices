#include <unistd.h>
#include "version.h"
#include <gflags/gflags.h>
#include <glog/logging.h>
#include <csignal>
#include "localBussiness/localBusiness.h"

#include "os/os.h"
#include "data/Data.h"

#include <fstream>
#include <dirent.h>
#include "glogHelper/GlogHelper.h"
#include "common/config.h"

#include "signalLight/SLType2/SLType2.h"

int signalIgnPipe() {
    struct sigaction act;

    memset(&act, 0, sizeof(act));
    sigemptyset(&act.sa_mask);
    act.sa_handler = SIG_IGN;
    if (sigaction(SIGPIPE, &act, NULL) < 0) {
        printf("call sigaction fail, %s\n", strerror(errno));
        return errno;
    }

    return 0;
}

DEFINE_int32(port, 9002, "本地服务端端口号，默认9002");
DEFINE_int32(keep, 5, "日志清理周期 单位day，默认5");

DEFINE_bool(isSendSTDOUT, false, "输出到控制台，默认false");
DEFINE_string(logDir, ".", "日志的输出目录,默认.");
DEFINE_string(msgType, "", "输出制定的信息类型，默认空，多个信息类型用英文逗号隔开");
DEFINE_int32(summaryFs, 10, "总结信息打印的频率，默认为10");

DEFINE_string(iniPath, "openDevicesConf.ini", "配置文件路径，默认openDevicesConf.ini");
DEFINE_string(eocConfPath, "eoc_configure.db", "eoc配置文件路径，默认eoc_configure.db");

DEFINE_int32(thresholdReconnect, 5, "多久没收到回复信息就重连，单位秒，默认 5");
DEFINE_bool(isUseThresholdReconnect, false, "是否启用没收到回复信息就重连，默认 false");

int main(int argc, char **argv) {
    gflags::SetVersionString(VERSION_BUILD_TIME);
    gflags::ParseCommandLineFlags(&argc, &argv, true);
    std::string proFul = std::string(argv[0]);
    std::string pro = os::getFileName(proFul);

    //日志系统类
    GlogHelper glogHelper(pro, FLAGS_keep, FLAGS_logDir, FLAGS_isSendSTDOUT);

    uint16_t port = FLAGS_port;
    LOG(WARNING) << "程序工作目录:" << string(get_current_dir_name()) << ",版本号:" << VERSION_BUILD_TIME;

    if (!FLAGS_msgType.empty()) {
        localConfig.msgType = os::split(FLAGS_msgType, ",");
    }
    localConfig.iniPath = FLAGS_iniPath;
    localConfig.eocConfPath = FLAGS_eocConfPath;

    if (FLAGS_summaryFs > 0) {
        localConfig.summaryFs = FLAGS_summaryFs;
    }
    if (FLAGS_thresholdReconnect > 0) {
        localConfig.thresholdReconnect = FLAGS_thresholdReconnect;
    }
    localConfig.isUseThresholdReconnect = FLAGS_isUseThresholdReconnect;

    getConfFromINI(FLAGS_iniPath);
    LOG(WARNING) << "通信协议版本:" << GetComVersion();

    auto dataLocal = Data::instance();
    signalIgnPipe();
    auto businessLocal = LocalBusiness::instance();

    businessLocal->AddServer("server1", port);

    //开启本地业务
    businessLocal->Run();

    //读取ini配置文件到本地

    //根据配置文件内容，开启相应的外部设备通信业务
    switch (localConfig.confSignalLight.type) {
        case 0: {
            //不开启
            LOG(WARNING) << " SignalLight 不开启";
        }
            break;
        case 1: {
            //不开启
            LOG(WARNING) << " SignalLight 开启kafka";
        }
            break;
        case 2: {
            //不开启
            LOG(WARNING) << " SignalLight 开启 tcp";
            SLType2 *slType2 = new SLType2(localConfig.confSignalLight.port);
            slType2->Open();
            slType2->Run();
            slType2->StartKeep();

        }
            break;
        case 3: {
            //不开启
            LOG(WARNING) << " SignalLight 开启 serial";
        }
            break;
        default: {

        }
            break;
    }
    new SLType2(localConfig.confSignalLight.port);

    while (true) {
        sleep(1);
    }

    return 0;
}
