#!/bin/sh
set -e

if test -n "${HTTP_PROXY}"; then
    echo "proxy=${HTTP_PROXY}" >> /etc/yum.conf
fi

echo "proxy=${HTTP_PROXY}"
cat /etc/yum.conf
yum -y install tar wget bzip2 git cmake automake autoconf

# get the latest gcc:
# https://www.softwarecollections.org/en/scls/rhscl/devtoolset-3/
yum -y install centos-release-scl
yum -y --nogpgcheck install devtoolset-3-gcc devtoolset-3-gcc-c++
echo "running scl enable: "
scl enable devtoolset-3 bash