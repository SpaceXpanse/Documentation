git clone https://github.com/google/googletest
cd googletest
cmake ${GTEST_DIR}
make
make install
ldconfig