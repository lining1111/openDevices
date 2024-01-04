//
// Created by lining on 2/16/22.
//

#ifndef _CRC_H
#define _CRC_H

#include <cstdint>

#ifdef __cplusplus
extern "C"
{
#endif

// Calculate the PkgCRC directly.
uint8_t Crc8Cal(uint8_t *data, uint32_t length, uint8_t poly, uint8_t init, uint8_t xorout, uint8_t reversed);
uint16_t Crc16Cal(uint8_t *data, uint32_t length, uint16_t poly, uint16_t init, uint16_t xorout, uint8_t reversed);
uint32_t Crc32Cal(uint8_t *data, uint32_t length, uint32_t poly, uint32_t init, uint32_t xorout, uint8_t reversed);

// Select the table-lookup method of computing the PkgCRC By setting this to 1.
// The table-lookup method will consume RAM, but faster.
#ifndef CRC_TABLE
#define CRC_TABLE 1
#endif

#if CRC_TABLE

//Name:    PkgCRC-8
//Poly:    0x07	x8+x2+x+1
//Init:    0x00
//Refin:   False
//Refout:  False
//Xorout:  0x00
uint8_t Crc8Tab(uint8_t *data, uint32_t length);

//Name:    PkgCRC-8/ITU
//Poly:    0x07	x8+x2+x+1
//Init:    0x00
//Refin:   False
//Refout:  False
//Xorout:  0x55
uint8_t Crc8TabITU(uint8_t *data, uint32_t length);

//Name:    PkgCRC-8/ROHC
//Poly:    0x07 x8+x2+x+1
//Init:    0xFF
//Refin:   True
//Refout:  True
//Xorout:  0x00
uint8_t Crc8TabROHC(uint8_t *data, uint32_t length);

//Name:    PkgCRC-8/MAXIM
//Poly:    0x31 x8+x5+x4+1
//Init:    0x00
//Refin:   True
//Refout:  True
//Xorout:  0x00
uint8_t Crc8TabMAXIM(uint8_t *data, uint32_t length);

//Name:    PkgCRC-16/IBM
//Poly:    0x8005 x16+x15+x2+1
//Init:    0x0000
//Refin:   True
//Refout:  True
//Xorout:  0x0000
uint16_t Crc16TabIBM(uint8_t *data, uint32_t length);

//Name:    PkgCRC-16/MAXIM
//Poly:    0x8005 x16+x15+x2+1
//Init:    0x0000
//Refin:   True
//Refout:  True
//Xorout:  0xFFFF
uint16_t Crc16TabMAXIM(uint8_t *data, uint32_t length);

//Name:    PkgCRC-16/USB
//Poly:    0x8005 x16+x15+x2+1
//Init:    0xFFFF
//Refin:   True
//Refout:  True
//Xorout:  0xFFFF
uint16_t Crc16TabUSB(uint8_t *data, uint32_t length);

//Name:    PkgCRC-16/MODBUS
//Poly:    0x8005 x16+x15+x2+1
//Init:    0xFFFF
//Refin:   True
//Refout:  True
//Xorout:  0x0000
uint16_t Crc16TabMODBUS(uint8_t *data, uint32_t length);

//Name:    PkgCRC-16/CCITT
//Poly:    0x1021 x16+x12+x5+1
//Init:    0x0000
//Refin:   True
//Refout:  True
//Xorout:  0x0000
uint16_t Crc16TabCCITT(uint8_t *data, uint32_t length);

//Name:    PkgCRC-16/CCITT-FALSE
//Poly:    0x1021 x16+x12+x5+1
//Init:    0xFFFF
//Refin:   False
//Refout:  False
//Xorout:  0x0000
uint16_t Crc16TabCCITTFALSE(uint8_t *data, uint32_t length);

//Name:    PkgCRC-16/X25
//Poly:    0x1021  x16+x12+x5+1
//Init:    0xFFFF
//Refin:   True
//Refout:  True
//Xorout:  0XFFFF
uint16_t Crc16TabX25(uint8_t *data, uint32_t length);

//Name:    PkgCRC-16/XMODEM
//Poly:    0x1021 x16+x12+x5+1
//Init:    0x0000
//Refin:   False
//Refout:  False
//Xorout:  0x0000
uint16_t Crc16TabXMODEM(uint8_t *data, uint32_t length);

//Name:    PkgCRC-32
//Poly:    0x04C11DB7 x32+x26+x23+x22+x16+x12+x11+x10+x8+x7+x5+x4+x2+x+1
//Init:    0xFFFFFFFF
//Refin:   True
//Refout:  True
//Xorout:  0xFFFFFFFF
uint32_t Crc32Tab(uint8_t *data, uint32_t length);

//Name:    PkgCRC-32/MPEG-2
//Poly:    0x04C11DB7 x32+x26+x23+x22+x16+x12+x11+x10+x8+x7+x5+x4+x2+x+1
//Init:    0xFFFFFFFF
//Refin:   False
//Refout:  False
//Xorout:  0x00000000
uint32_t Crc32TabMPEG2(uint8_t *data, uint32_t length);

#endif

#ifdef __cplusplus
}
#endif

#endif //_CRC_H
