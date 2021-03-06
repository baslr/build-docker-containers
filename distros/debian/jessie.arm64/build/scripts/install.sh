#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"

dpkg --add-architecture arm64
apt-get update
apt-get install -y tar wget bzip2 automake autoconf python-argparse apt-utils apt-transport-https debhelper python python-pip debhelper

pip install lockfile

cd /tmp/
wget http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0//Release.key
apt-key add - < Release.key
rm Release.key

echo 'deb http://ftp.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/backports.list
echo 'deb http://download.opensuse.org/repositories/home:/fceller2/Debian_8.0/ /' | tee /etc/apt/sources.list.d/arangodbbuild.list
echo 'deb http://emdebian.org/tools/debian/ jessie main' | tee /etc/apt/sources.list.d/emedian.list
wget http://emdebian.org/tools/debian/emdebian-toolchain-archive.key
apt-key add - < emdebian-toolchain-archive.key

apt-get update
apt-get -t jessie-backports install -y git
apt-get -t jessie-backports install -y cmake

apt-get purge -y libssl-dev

apt-get install -y g++-4.9-aarch64-linux-gnu g++-aarch64-linux-gnu gcc-aarch64-linux-gnu libssl-dev:arm64 libstdc++6:arm64

# for dpkg-shlibdebs we need this:
dpkg -r gcc  g++ build-essential
cd /usr/bin
ln -s aarch64-linux-gnu-gcc gcc

 
useradd jenkins -u 1000

echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/bashrc
echo 'PATH=/opt/arangodb/bin/:${PATH}' >> /etc/profile
