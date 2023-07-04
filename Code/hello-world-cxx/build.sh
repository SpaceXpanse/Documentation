#!/bin/sh -e

packages="libspex jsoncpp libglog gflags libzmq openssl"

g++ hello.cpp -o hello \
  -Wall -Werror -Wno-deprecated -Wno-deprecated-declarations -pedantic -std=c++14 -DGLOG_NO_ABBREVIATED_SEVERITIES \
  `pkg-config --cflags ${packages}` \
  `pkg-config --libs ${packages}` \
  -pthread \
  -lstdc++fs