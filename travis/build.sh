#!/bin/bash

# Install dependencies
yum install -y gcc-gfortran cmake autoconf automake libtool

./bootstrap
./configure --prefix=$PWD

make install

# Only test with Python3
for PYBIN in /opt/python/cp3*/bin; do
    echo "${PYBIN}"
    "${PYBIN}/pip" install -r /io/test/requirements.txt
    "${PYBIN}/pytest"
done

mkdir -p /io/build
cp -R lib /io/build/
cp -R share /io/build/
