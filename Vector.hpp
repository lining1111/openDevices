//
// Created by lining on 2023/5/29.
//

#ifndef VECTOR_H
#define VECTOR_H

#include <vector>
#include <pthread.h>
#include <mutex>

using namespace std;


template<typename T>
class Vector {
public:
    Vector() {
        if (mtx == nullptr){
            mtx = new std::mutex();
        }
    }

    Vector(unsigned int max) {
        if (mtx == nullptr){
            mtx = new std::mutex();
        }
        setMax(max);
    }

    ~Vector() {
        delete mtx;
    }

    bool push(T t) {
        std::unique_lock<std::mutex> lock(*mtx);
        //先将数据压入
        q.push_back(t);

        //当设定最大值的时候,如果达到最大值,将头部数据删除
        if (isSetMax) {
            if (q.size() > max) {
                q.erase(q.begin());
            }
        }
        return true;
    }

    bool getIndex(T &t, int index) {
        if ((q.size() < (index + 1)) || index < 0 || q.empty()) {
            return false;
        }
        std::unique_lock<std::mutex> lock(*mtx);
        t = q.at(index);
        return true;
    }

    void eraseBegin() {
        if (!q.empty()) {
            std::unique_lock<std::mutex> lock(*mtx);
            q.erase(q.begin());
        }
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
        vector<T> q1;
        swap(q, q1);
    }

private:
    int max;
    bool isSetMax = false;
    vector<T> q;
    std::mutex *mtx= nullptr;
};


#endif //VECTOR_H
