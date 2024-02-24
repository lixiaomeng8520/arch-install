#!/bin/bash

set -e

# 设置时间
echo '* 设置时间'
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc #TODO
# 设置语言
echo '* 设置语言'
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
# 设置hostname
echo '* 设置hostname'
echo 'Ryzen5600G' > /etc/hostname

# 设置root密码
echo '* 设置root密码'
passwd
# 添加普通用户
if ! id lxm ; then
    echo '* 添加普通用户'
    useradd -m lxm
    passwd lxm
    echo 'lxm ALL=(ALL:ALL) ALL' >> /etc/sudoers
fi


# 设置bootloader
echo '* 设置bootloader'
pacman -S amd-ucode grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
efibootmgr
