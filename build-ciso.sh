#!/usr/bin/env bash

VERSION=1.0.2
ARCHIVE=v${VERSION}.tar.gz

cd ${HOME}
wget -O /tmp/${ARCHIVE} https://github.com/jamie/ciso/archive/${ARCHIVE}
tar xvfz /tmp/${ARCHIVE}
cd ciso-${VERSION}
make
make install

cd ${HOME}
rm -rf ciso-${VERSION}
rm /tmp/${ARCHIVE}
