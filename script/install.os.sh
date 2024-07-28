#!/bin/bash

set -e

export http_proxy=http://192.168.10.3:7890
export https_proxy=http://192.168.10.3:7890

# 安装工具
echo '* install tools'
sudo pacman -S chrony which rsync openssh less pacman-contrib bash-completion base-devel
sudo systemctl enable --now chronyd

# 创建workspace
echo '* 创建workspace'
mkdir -p ~/workspace

# 安装paru
echo '* 安装paru'
if ! which paru; then
    rm -rf ~/workspace/paru
    git clone https://aur.archlinux.org/paru.git ~/workspace/paru
    cd ~/workspace/paru
    makepkg -si
fi

# 安装桌面软件
echo '* 安装lightdm、bspwm及组件'
sudo pacman -S lightdm lightdm-gtk-greeter # lightdm会默认加载light-gtk-greeter,如果不安装，启动lightdm会报错，也不会显示登录界面
sudo systemctl enable lightdm
sudo pacman -S bspwm # 执行上步之后，可以显示登录界面，但是无法登录，会显示错误无法找到默认session，应该是寻找/usr/share/xsessions目录下的条目，所以需要安装一个session,如bspwm
sudo pacman -S sxhkd picom polybar plank alacritty rofi feh xdo # 部分组件

# 字体
echo '* 安装字体'
sudo pacman -S noto-fonts noto-fonts-emoji ttf-cascadia-code-nerd
paru noto-fonts-sc

# 输入法
echo '* install fcitx5'
sudo pacman -S fcitx5-im fcitx5-chinese-addons

# 声音
echo '* install audio'
# sudo pacman -S pipewire-alsa alsa-utils
sudo pacman -S pulsemixer

# 蓝牙
echo '* install bluetooth'
sudo pacman -S blueman pipewire-pulse
sudo systemctl enable --now bluetooth

# vnc
echo '* install tigervnc'
sudo pacman -S tigervnc # 生成vnc密码，默认~/.vnc/passwd
vncpasswd

# 虚拟化
echo '* 安装虚拟化'
sudo pacman -S virt-manager qemu-full
sudo systemctl enable --now libvirtd
sudo usermod -a -G libvirt lxm

# 拷贝配置
echo '* 拷贝配置'
mkdir -p ~/.config/bspwm ~/.config/sxhkd ~/.config/picom ~/.config/polybar ~/.config/alacritty
ln -sf ~/arch-install/bspwmrc ~/.config/bspwm/bspwmrc
ln -sf ~/arch-install/sxhkdrc ~/.config/sxhkd/sxhkdrc
ln -sf ~/arch-install/picom.conf ~/.config/picom/picom.conf
ln -sf ~/arch-install/polybar.ini ~/.config/polybar/config.ini
ln -sf ~/arch-install/alacritty.toml ~/.config/alacritty/alacritty.toml
if [ ! -d ~/.config/alacritty/alacritty-theme ]; then
    git clone https://github.com/alacritty/alacritty-theme.git ~/.config/alacritty/alacritty-theme
fi
ln -sf ~/arch-install/xprofile ~/.xprofile
sudo ln -sf ~/arch-install/lightdm.conf /etc/lightdm/lightdm.conf
sudo ln -sf ~/arch-install/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
chmod o+x ~ # 为了使lightdm-gtk-greeter的背景图片生效
mkdir -p ~/.local/share/plank/themes/Transparent
ln -sf ~/arch-install/plank-transparent.theme ~/.local/share/plank/themes/Transparent/dock.theme
sudo ln -sf ~/arch-install/xorg.conf.d/00-mouse.conf /etc/X11/xorg.conf.d/00-mouse.conf
sudo ln -sf ~/arch-install/xorg.conf.d/10-monitor.conf /etc/X11/xorg.conf.d/10-monitor.conf
sudo ln -sf ~/arch-install/xorg.conf.d/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf


# **********启动*********
reboot
# 拼音输入法，运行config tools,添加pinyin

# 其他软件
# paru google-chrome visual-studio-code-bin typora