#!/bin/sh
set -ex
openttd_version=1.10.3
opengfx_version=0.6.0
cd /build/
apt-get update
apt-get upgrade -y
apt-get install -y \
    wget \
    unzip \
    xz-utils \
    build-essential \
    pkg-config \
    zlib1g \
    zlib1g-dev \
    liblzma5 \
    liblzma-dev \
    liblzo2-2 \
    liblzo2-dev \
    libpng16-16 \
    libpng-dev
wget https://proxy.binaries.openttd.org/openttd-releases/$openttd_version/openttd-$openttd_version-source.tar.xz
wget https://cdn.openttd.org/opengfx-releases/$opengfx_version/opengfx-$opengfx_version-all.zip
tar -xvf openttd-$openttd_version-source.tar.xz
cd openttd-$openttd_version
./configure \
    --prefix-dir=/usr \
    --personal-dir=. \
    --enable-lto \
    --enable-dedicated \
    --enable-strip
make install
cd /build
unzip opengfx-$opengfx_version-all.zip
mv opengfx-$opengfx_version.tar /usr/share/games/openttd/baseset/opengfx-$opengfx_version.tar
useradd -ms /bin/sh -d /data openttd
apt-get remove -y \
    wget \
    unzip \
    xz-utils \
    build-essential \
    pkg-config \
    zlib1g-dev \
    liblzma-dev \
    liblzo2-dev \
    libpng-dev
apt-get autoremove -y
apt-get clean
rm -rvf /build /var/lib/apt/lists/*
