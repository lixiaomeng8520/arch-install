#!/bin/bash

set -e

# 分区，一个主分区，一个efi分区（如果已安装windows,则直接使用该分区）。
# 格式化
echo '* 格式化'
mkfs.ext4 /dev/nvme0n1p6	# 主分区
# mkfs.fat -F 32 /dev/xxx		# efi分区，可选

# 挂载分区
echo '* 挂载分区'
mount /dev/nvme0n1p6 /mnt	# 挂载主分区
mount --mkdir /dev/nvme0n1p1 /mnt/efi # 不要挂载在boot,避免efi分区过度增长。

# 配置源
echo '* 配置源'
echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

# 安装基础包
echo '* 安装基础包'
pacstrap -K /mnt base linux linux-firmware networkmanager sudo vi vim

# 生成fstab文件
echo '* 生成fstab文件'
genfstab -U /mnt >> /mnt/etc/fstab

# 拷贝arch-install到/mnt
cp ~/arch-install /mnt

# arch-chroot /mnt