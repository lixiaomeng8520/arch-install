#!/bin/bash

# 设置时间
echo '* 设置时间'
timedatectl set-timezone Asia/Shanghai

# 非交互式连接网络
echo '* 连接网络'
iwctl device list # 列出无线网卡
iwctl station wlan0 connect hannah5 # 连接

pacman -S git
git config --global http.proxy http://192.168.10.3
git config --global https.proxy http://192.168.10.3

rm -rf ~/arch-install
git clone https://github.com/lixiaomeng8520/arch-install.git ~