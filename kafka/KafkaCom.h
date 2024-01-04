//
// Created by lining on 2023/12/14.
//

#ifndef RVDATAFUSIONSERVER_KAFKACOM_H
#define RVDATAFUSIONSERVER_KAFKACOM_H
#include <string>
#include <stdlib.h>

#pragma pack(1)
typedef struct {
    uint8_t header[4];
    unsigned char NoTab;                //表号 4
    unsigned char NumByte;            //表格字节长度
} TabStageFrameHeader;

typedef struct {
    unsigned char NoArea;                //区域号，相应路口所属区域
    unsigned char NoJunc;                //路口号，当前相位发生变化的路口
    unsigned char NoOldStage;            //上一相位号
    unsigned char LenOldStage;        //上一相位长(秒)
    unsigned char NoNewStage;            //当前相位号
    unsigned char LenNewStage;        //当前相位长(秒)
    char NewStageName[40];   //当前相位名（相位名对应下列字典，可忽略）
} TabStage;


typedef struct {
    TabStageFrameHeader frameHeader;
    TabStage tabStage;
} TabStageWithHeader;

#pragma pack()



#endif //RVDATAFUSIONSERVER_KAFKACOM_H
