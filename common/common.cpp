//
// Created by lining on 2024/1/4.
//

#include "common.h"
#include <cstring>
#include <sys/time.h>
#include <iostream>
#include "CRC.h"
#include <glog/logging.h>

namespace common {
    string GetComVersion() {
        return ComVersion;
    }

    uint32_t Pack(Pkg &pkg, uint8_t *out, uint32_t len) {
        //判断长度是否满足
        if (len < (sizeof(pkg.head) + sizeof(pkg.crc) + pkg.body.length())) {
            return 0;
        }

        uint32_t index = 0;

        //1.头部
        memcpy(out + index, &pkg.head, sizeof(pkg.head));
        index += sizeof(pkg.head);
        //2.正文 string
        memcpy(out + index, pkg.body.data(), pkg.body.length());
        index += pkg.body.length();
        //3.校验值先计算再更新
        pkg.crc.data = Crc16TabCCITT(out, index);
        memcpy(out + index, &pkg.crc, sizeof(pkg.crc));
        index += sizeof(pkg.crc);

        //如果最后拷贝的长度和头部信息的长度相同则说明组包成功，否则失败
        if (index != pkg.head.len) {
            return 0;
        } else {
            return index;
        }
    }


    int Unpack(uint8_t *in, uint32_t len, Pkg &pkg) {
        uint32_t index = 0;

        //长度小于头部长度 退出
        if (len < sizeof(pkg.head)) {
            cout << "长度小于头部长度" << endl;
            return -1;
        }

        //1.头部
        memcpy(&pkg.head, in + index, sizeof(pkg.head));
        index += sizeof(pkg.head);

        //判断长度，如果 len小于头部长度则退出
        if (len < pkg.head.len) {
            cout << "长度小于数据长度" << endl;
            return -1;
        }

        //2.正文string
        pkg.body.clear();
        pkg.body.assign((char *) (in + index), (pkg.head.len - sizeof(pkg.head) - sizeof(pkg.crc)));
        index += (pkg.head.len - sizeof(pkg.head) - sizeof(pkg.crc));
        //3.校验值
        memcpy(&pkg.crc, in + index, sizeof(pkg.crc));
        index += sizeof(pkg.crc);

        //如果最后拷贝的长度和参数长度相同则说明组包成功，否则失败
        if (index != len) {
            return -1;
        } else {
            return 0;
        }
    }

    void PrintSendInfo(int s, string serverIp, int serverPort,
                       string name, uint64_t timestampS, uint64_t timestampE, uint64_t timestamp) {
        switch (s) {
            case 0: {
                LOG(INFO) << name << " 发送成功 " << serverIp << ":" << serverPort
                          << ",发送开始时间:" << to_string(timestampS)
                          << ",发送结束时间:" << to_string(timestampE)
                          << ",帧内时间:" << to_string(timestamp)
                          << ",耗时:" << (timestampE - timestampS) << " ms";
            }
                break;
            case -1: {
                LOG(INFO) << name << " 发送失败,未连接 " << serverIp << ":" << serverPort
                          << ",发送开始时间:" << to_string(timestampS)
                          << ",发送结束时间:" << to_string(timestampE)
                          << ",帧内时间:" << to_string(timestamp)
                          << ",耗时:" << (timestampE - timestampS) << " ms";
            }
                break;
            case -2: {
                LOG(INFO) << name << " 发送失败,send fail " << serverIp << ":" << serverPort
                          << ",发送开始时间:" << to_string(timestampS)
                          << ",发送结束时间:" << to_string(timestampE)
                          << ",帧内时间:" << to_string(timestamp)
                          << ",耗时:" << (timestampE - timestampS) << " ms";
            }
                break;
            case -3: {
                LOG(INFO) << name << " 发送失败,发送超时 " << serverIp << ":" << serverPort
                          << ",发送开始时间:" << to_string(timestampS)
                          << ",发送结束时间:" << to_string(timestampE)
                          << ",帧内时间:" << to_string(timestamp)
                          << ",耗时:" << (timestampE - timestampS) << " ms";
            }
                break;
            default: {

            }
                break;
        }
    }

    void PrintSendInfoFs(int fs, int s, string serverIp, int serverPort,
                         string name, uint64_t timestampS, uint64_t timestampE, uint64_t timestamp) {
        switch (s) {
            case 0: {
                LOG_EVERY_N(INFO, fs) << name << " 发送成功 " << serverIp << ":" << serverPort
                                      << ",发送开始时间:" << to_string(timestampS)
                                      << ",发送结束时间:" << to_string(timestampE)
                                      << ",帧内时间:" << to_string(timestamp)
                                      << ",耗时:" << (timestampE - timestampS) << " ms";
            }
                break;
            case -1: {
                LOG_EVERY_N(INFO, fs) << name << " 发送失败,未连接 " << serverIp << ":" << serverPort
                                      << ",发送开始时间:" << to_string(timestampS)
                                      << ",发送结束时间:" << to_string(timestampE)
                                      << ",帧内时间:" << to_string(timestamp)
                                      << ",耗时:" << (timestampE - timestampS) << " ms";
            }
                break;
            case -2: {
                LOG_EVERY_N(INFO, fs) << name << " 发送失败,send fail " << serverIp << ":" << serverPort
                                      << ",发送开始时间:" << to_string(timestampS)
                                      << ",发送结束时间:" << to_string(timestampE)
                                      << ",帧内时间:" << to_string(timestamp)
                                      << ",耗时:" << (timestampE - timestampS) << " ms";
            }
                break;
            case -3: {
                LOG_EVERY_N(INFO, fs) << name << " 发送失败,发送超时 " << serverIp << ":" << serverPort
                                      << ",发送开始时间:" << to_string(timestampS)
                                      << ",发送结束时间:" << to_string(timestampE)
                                      << ",帧内时间:" << to_string(timestamp)
                                      << ",耗时:" << (timestampE - timestampS) << " ms";
            }
                break;
            default: {

            }
                break;
        }
    }

}
