#!/bin/sh

./scripts/feeds update -a
./scripts/feeds install -a

find ./ | grep Makefile | grep mosdns | xargs rm -f
if [ -d package/mosdns ]; then
    rm -rf package/mosdns
fi
git clone -b v5 https://github.com/sbwml/luci-app-mosdns package/mosdns
cd package/mosdns || exit 1
git checkout c31e112465cb564180f04871bc6694a22ad11fa5
cd - || exit 1

if [ -d package/lean/luci-app-poddns ]; then
    rm -rf package/lean/luci-app-poddns
fi
git clone https://github.com/fonlan/luci-app-poddns package/lean/luci-app-poddns

if [ -d package/autoban ]; then
    rm -rf package/autoban
fi
git clone https://github.com/fonlan/autoban package/autoban

make defconfig
make menuconfig

make -j$(nproc) V=s
#make -j4 V=s
