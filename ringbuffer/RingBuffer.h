//
// Created by lining on 1/11/23.
//

#ifndef _RINGBUFFER_H
#define _RINGBUFFER_H

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <mutex>


class RingBuffer {
private:
    std::mutex *mtx = nullptr;
    uint8_t *buff = nullptr;

    size_t capacity;
    int read_pos;
    int write_pos;
    int available_for_read;
    int available_for_write;
    //int available_for_write = rb_capacity - available_for_read;
public:
    RingBuffer(size_t capacity);

    ~RingBuffer();

public:
    size_t Read(void *data, size_t count);

    size_t Write(const void *data, size_t count);

    int GetReadLen();

    int GetWriteLen();
};


#endif //_RINGBUFFER_H
