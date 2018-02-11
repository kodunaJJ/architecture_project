cmake_minimum_required(VERSION 2.6)
project(cnn_cifiar10)
add_definitions(${GCC_COVERAGE_COMPILE_FLAGS})

add_executable(cnn_cifar10 main.cpp)
