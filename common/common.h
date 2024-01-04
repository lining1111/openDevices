//
// Created by lining on 2024/1/4.
//

#ifndef _COMMON_H
#define _COMMON_H

#include <cstdint>
#include <string>
#include <vector>
#include <uuid/uuid.h>

using namespace std;

#include <xpack/json.h>

using namespace xpack;

namespace common {
#define ARRAY_SIZE(x) \
    (sizeof(x)/sizeof(x[0]))
#define OFFSET(type, member)      \
    ((size_t)(&(((type*)0)->member)))
#define MEMBER_SIZE(type, member) \
    sizeof(((type *)0)->member)
#define STR(p) p?p:""

    void PrintSendInfo(int s, string serverIp, int serverPort,
                       string name, uint64_t timestampS, uint64_t timestampE, uint64_t timestamp);

    void PrintSendInfoFs(int fs, int s, string serverIp, int serverPort,
                         string name, uint64_t timestampS, uint64_t timestampE, uint64_t timestamp);

    /**
     * 整体通信大帧结构
     *  1byte   1byte   1byte       2bytes  4bytes  4bytes  Nbytes      2bytes
     *  帧头      版本  命令标识符       帧号  设备编号    帧长  json格式正文    校验码
     */


#define ComVersion "0.0.1"

    string GetComVersion();

    enum CmdType {
        CmdResponse = 0x00,//应答指令
        CmdHeartBeat = 0x02,//心跳
        CmdSignalLightState = 0xfd,//信号灯状态

        CmdUnknown = 0xff,
    };

#pragma pack(1)
    typedef struct {
        uint8_t tag = '$';//固定的头开始 ‘$’ 0x24
        uint8_t version;//版本号 1.0 hex
        uint8_t cmd = CmdUnknown;//命令字类型 详见CmdType
        uint16_t sn = 0;//帧号
        uint32_t deviceNO;//设备编号
        uint32_t len = 0;//整包长度，从包头到最后的校验位 <帧头>sizeof(PkgHead)+<正文>(json)+<校验>sizeof(PkgCRC)
    } PkgHead;//包头
    typedef struct {
        uint16_t data;//校验值，从帧头开始到正文的最后一个字节
    } PkgCRC;
#pragma pack()

    //一帧数据格式 <帧头>PkgHead+<正文>string(json)+<校验>PkgCRC
    typedef struct {
        PkgHead head;
        string body;
        PkgCRC crc;
    } Pkg;

    class PkgClass {
    public:
        CmdType cmdType;
    XPACK(O(cmdType));

        int PkgWithoutCRC(uint16_t sn, uint32_t deviceNO, Pkg &pkg) {
            int len = 0;
            //1.头部
            pkg.head.tag = '$';
            pkg.head.version = 1;
            pkg.head.cmd = this->cmdType;
            pkg.head.sn = sn;
            pkg.head.deviceNO = deviceNO;
            pkg.head.len = 0;
            len += sizeof(pkg.head);
            //正文
            string jsonStr = json::encode(*this);
            pkg.body = jsonStr;
            len += jsonStr.length();
            //校验,可以先不设置，等待组包的时候更新
            pkg.crc.data = 0x0000;
            len += sizeof(pkg.crc);
            pkg.head.len = len;
            return 0;
        }
    };

    /**
     * 组包函数,此时pkg内 校验码不对，要在组包的时候更新校验码
     * @param pkg 帧数据
     * @param out 组帧后的数据缓存地址
     * @param len 组帧后的数据缓存长度
     * @return 0：fail 实际数据长度
     */
    uint32_t Pack(Pkg &pkg, uint8_t *out, uint32_t len);


    /**
     * 解包数据
     * @param in 一帧数据包
     * @param len 一阵数据包长度
     * @param pkg 解包后的数据帧
     * @return 0：success -1：fail
     */
    int Unpack(uint8_t *in, uint32_t len, Pkg &pkg);

    //回复帧
    class Reply : public PkgClass {
    public:
        int state;// `json "state"`
        string desc;// `json "desc"`
        string oprNum;
    public:
        Reply() {
            this->cmdType = CmdResponse;
        }

    XPACK(O(state, desc, oprNum));

        int PkgWithoutCRC(uint16_t sn, uint32_t deviceNO, Pkg &pkg) {
            int len = 0;
            //1.头部
            pkg.head.tag = '$';
            pkg.head.version = 1;
            pkg.head.cmd = this->cmdType;
            pkg.head.sn = sn;
            pkg.head.deviceNO = deviceNO;
            pkg.head.len = 0;
            len += sizeof(pkg.head);
            //正文
            string jsonStr = json::encode(*this);
            pkg.body = jsonStr;
            len += jsonStr.length();
            //校验,可以先不设置，等待组包的时候更新
            pkg.crc.data = 0x0000;
            len += sizeof(pkg.crc);
            pkg.head.len = len;
            return 0;
        }
    };

    //心跳帧 "Beats"
    class Beats : public PkgClass {
    public:
        string hardCode;// `json "hardCode"` 设备唯一标识
        double timestamp;// `json "timstamp"` 自1970.1.1 00:00:00到当前的秒数 date +%s获取秒数 date -d @秒数获取时间格式
    public:
        Beats() {
            this->cmdType = CmdHeartBeat;
        }

    XPACK(O(hardCode, timestamp));

        int PkgWithoutCRC(uint16_t sn, uint32_t deviceNO, Pkg &pkg) {
            int len = 0;
            //1.头部
            pkg.head.tag = '$';
            pkg.head.version = 1;
            pkg.head.cmd = this->cmdType;
            pkg.head.sn = sn;
            pkg.head.deviceNO = deviceNO;
            pkg.head.len = 0;
            len += sizeof(pkg.head);
            //正文
            string jsonStr = json::encode(*this);
            pkg.body = jsonStr;
            len += jsonStr.length();
            //校验,可以先不设置，等待组包的时候更新
            pkg.crc.data = 0x0000;
            len += sizeof(pkg.crc);
            pkg.head.len = len;
            return 0;
        }
    };

    enum MatrixNo_GB {
        MatrixNo_GB_North = 0,
        MatrixNo_GB_Northeast = 1,
        MatrixNo_GB_East = 2,
        MatrixNo_GB_Southeast = 3,
        MatrixNo_GB_South = 4,
        MatrixNo_GB_Southwest = 5,
        MatrixNo_GB_West = 6,
        MatrixNo_GB_Northwest = 7,
    };

    enum matrixNo_NoGB {
        MatrixNo_NoGB_North = 4,
        MatrixNo_NoGB_Northeast = 7,
        MatrixNo_NoGB_East = 1,
        MatrixNo_NoGB_Southeast = 5,
        MatrixNo_NoGB_South = 2,
        MatrixNo_NoGB_Southwest = 6,
        MatrixNo_NoGB_West = 3,
        MatrixNo_NoGB_Northwest = 8,
    };

    //SignalLightState
    class SignalLightState_lstIntersections_item {
    public:
        string matrixNo;//端口序号
        int left;//左转红灯状态 0灭1亮
        int right;//右转红灯状态 0灭1亮
        int straight;//直行红灯状态 0灭1亮
    XPACK(O(matrixNo, left, right, straight));
    };


    class SignalLightState : public PkgClass {
    public:
        string oprNum;
        double timestamp;// `json "timstamp"` 自1970.1.1 00:00:00到当前的秒数 date +%s获取秒数 date -d @秒数获取时间格式
        string crossID;
        string hardCode;// `json "hardCode"` 设备唯一标识
        vector<SignalLightState_lstIntersections_item> lstIntersections;
    public:
        SignalLightState() {
            this->cmdType = CmdSignalLightState;
            uuid_t uuid;
            char uuid_str[37];
            memset(uuid_str, 0, 37);
            uuid_generate_time(uuid);
            uuid_unparse(uuid, uuid_str);
            this->oprNum = string(uuid_str);

        }

    XPACK(O(oprNum, timestamp, crossID, hardCode, lstIntersections));

        int PkgWithoutCRC(uint16_t sn, uint32_t deviceNO, Pkg &pkg) {
            int len = 0;
            //1.头部
            pkg.head.tag = '$';
            pkg.head.version = 1;
            pkg.head.cmd = this->cmdType;
            pkg.head.sn = sn;
            pkg.head.deviceNO = deviceNO;
            pkg.head.len = 0;
            len += sizeof(pkg.head);
            //正文
            string jsonStr = json::encode(*this);
            pkg.body = jsonStr;
            len += jsonStr.length();
            //校验,可以先不设置，等待组包的时候更新
            pkg.crc.data = 0x0000;
            len += sizeof(pkg.crc);
            pkg.head.len = len;
            return 0;
        }
    };

};


#endif //_COMMON_H
