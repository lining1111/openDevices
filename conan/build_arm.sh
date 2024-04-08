#!/bin/bash
echo "arm conan build"
rm -rf build/*
conan install . -pr:b=default  -pr:h=arm --build=missing --output-folder=build
