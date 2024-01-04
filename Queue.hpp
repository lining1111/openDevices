//
// Created by lining on 10/1/22.
//

#ifndef _QUEUE_H
#define _QUEUE_H


#include <queue>
#include <sys/time.h>
#include <pthread.h>
#include <mutex>

using namespace std;

template<typename T>
class Queue {
public:
    Queue() {
        if (mtx == nullptr){
            mtx = new std::mutex();
        }
    }

    Queue(unsigned int max) {
        if (mtx == nullptr){
            mtx = new std::mutex();
        }
        setMax(max);
    }

    ~Queue() {
        delete mtx;
    }

    bool push(T t) {
        if (isSetMax) {
            if (q.size() >= max) {
                return false;
            }
        }
        std::unique_lock<std::mutex> lock(*mtx);
        q.push(t);
        return true;
    }

    bool pop(T &t) {
        if (q.empty()) {
            return false;
        }
        std::unique_lock<std::mutex> lock(*mtx);
        t = q.front();
        q.pop();
        return true;
    }

    bool front(T &t) {
        if (q.empty()) {
            return false;
        }
        std::unique_lock<std::mutex> lock(*mtx);
        t = q.front();
        return true;
    }

    bool back(T &t) {
        if (q.empty()) {
            return false;
        }
        std::unique_lock<std::mutex> lock(*mtx);
        t = q.back();
        return true;
    }


    void setMax(int value) {
        max = value;
        isSetMax = true;
    }

    int size() {
        return q.size();
    }

    bool empty() {
        return q.empty();
    }

    void clear() {
        queue<T> q1;
        swap(q, q1);
    }

private:
    // 如何保证对这个队列的操作是线程安全的？引入互斥锁

    queue<T> q;

    int max;
    bool isSetMax = false;
    std::mutex *mtx= nullptr;

};

#endif //_QUEUE_H
