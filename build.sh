#!/bin/sh
mkdir -p /src/build
mkdir -p /src/binaries
cd /src/build || exit 255
cmake .. -Wno-dev -DPREFIX=/tc \
        -DOPENSSL_SSL_LIBRARIES=/usr/lib/x86_64-linux-gnu/libssl.so \
        -DOPENSSL_CRYPTO_LIBRARIES=/usr/lib/x86_64-linux-gnu/libcrypto.so \
        -DREADLINE_LIBRARY=/lib/x86_64-linux-gnu/libreadline.so.5 \
        -DBZIP2_LIBRARIES=/usr/lib/x86_64-linux-gnu/libbz2.so \
        -DZLIB_LIBRARY=/usr/lib/x86_64-linux-gnu/libz.so \
        -DWITH_WARNINGS=0 \
        -DWITH_COREDEBUG=0 \
        -DUSE_COREPCH=1 \
        -DUSE_SCRIPTPCH=1 \
        -DTOOLS=0 \
        -DSCRIPTS=1 \
        -DNOJEM=0 \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DCMAKE_CXX_FLAGS="-std=c++11 -m64 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -pipe -fno-strict-aliasing" \
        -DCMAKE_C_FLAGS="-m64 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -pipe -fno-strict-aliasing" \
  || exit 255
make -j4 || exit 255
make install || exit 255
cp -rf /tc/* /src/binaries/
