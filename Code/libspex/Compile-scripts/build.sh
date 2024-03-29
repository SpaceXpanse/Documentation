#!/bin/bash

# Install required packages
pacman -Sy base-devel git mingw-w64-x86_64-toolchain make mingw-w64-x86_64-cmake autoconf-archive mingw-w64-x86_64-protobuf mingw-w64-x86_64-gtest mingw-w64-x86_64-gflags mingw-w64-x86_64-zeromq mingw-w64-x86_64-openssl mingw-w64-x86_64-glog mingw-w64-x86_64-lmdb mingw-w64-x86_64-lmdbxx mingw-w64-x86_64-sqlite3 mingw-w64-x86_64-libmicrohttpd libtool mingw-w64-x86_64-autotools wget

# Build argtable2
git clone https://github.com/RyuMaster/argtable2.git
cd argtable2
cmake . -G"MSYS Makefiles" -DCMAKE_INSTALL_PREFIX=$MINGW_PREFIX
make -j2
make install
cp ./src/argtable2.h /home/../mingw64/include/argtable2.h
cd ..

# Build libjson-rpc-cpp
git clone https://github.com/RyuMaster/libjson-rpc-cpp.git
cd libjson-rpc-cpp
git checkout listen-locally-0.7.0
mkdir win32-deps
mkdir win32-deps/include
cmake . -G"MSYS Makefiles" -DCMAKE_INSTALL_PREFIX=$MINGW_PREFIX -DREDIS_SERVER=NO -DREDIS_CLIENT=NO -DCOMPILE_STUBGEN=YES -DCOMPILE_EXAMPLES=NO -DCOMPILE_TESTS=NO -DBUILD_STATIC_LIBS=YES -DHUNTER_ENABLED=YES -DCMAKE_CXX_FLAGS="-fpermissive"
make -j2
make install
cd dist
cp -r ./ /home/../mingw64/
cd ~/

# Obtain libglog.pc and lmdb.pc files
curl -o /home/../mingw64/lib/pkgconfig/libglog.pc https://raw.githubusercontent.com/xaya/XAYA_tutorial_code/master/libxayagame/Compile-scripts/libglog.pc
curl -o /home/../mingw64/lib/pkgconfig/lmdb.pc https://raw.githubusercontent.com/xaya/XAYA_tutorial_code/master/libxayagame/Compile-scripts/lmdb.pc

# Build secp256k1
git clone https://github.com/bitcoin-core/secp256k1.git
cd secp256k1
./autogen.sh
./configure --disable-tests --disable-benchmark --enable-module-recovery
make
make install
cd ..

# Build eth-utils
git clone https://github.com/xaya/eth-utils.git
cd eth-utils
./autogen.sh
./configure
make
make install
cd ..

# Build libspex
git clone https://github.com/spacexpanse/libspex.git
cd libspex
curl -o configure_patch.diff https://raw.githubusercontent.com/xaya/XAYA_tutorial_code/master/libxayagame/Compile-scripts/configure_patch.diff
patch --merge configure.ac configure_patch.diff
./autogen.sh
CXXFLAGS="-fpermissive -Wno-deprecated-declarations" ./configure --enable-shared
make -j2
make install

# Script execution complete
