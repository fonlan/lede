#!/bin/sh

./scripts/feeds update -a
./scripts/feeds install -a

find ./ | grep Makefile | grep mosdns | xargs rm -f
if [ -d package/mosdns ]; then
    rm -rf package/mosdns
fi
git clone -b v5 https://github.com/sbwml/luci-app-mosdns package/mosdns

if [ -d package/lean/luci-app-poddns ]; then
    rm -rf package/lean/luci-app-poddns
fi
git clone https://github.com/fonlan/luci-app-poddns package/lean/luci-app-poddns

# find ./ | grep Makefile | grep luci-theme-argon | xargs rm -f
# if [ -d package/lean/luci-theme-argon ]; then
#     rm -rf package/lean/luci-theme-argon
# fi
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon

if [ -d package/autoban ]; then
    rm -rf package/autoban
fi
git clone https://github.com/fonlan/autoban package/autoban

make defconfig
make menuconfig

make -j$(nproc) V=s
