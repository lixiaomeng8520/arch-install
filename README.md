# arch-install

## usb - outer

```bash
export http_proxy=http://192.168.10.3:7890
export https_proxy=http://192.168.10.3:7890

echo '* 设置时间'
timedatectl set-timezone Asia/Shanghai

# 非交互式连接网络
echo '* 连接网络'
iwctl device list # 列出无线网卡
iwctl station wlan0 connect hannah5 # 连接

wget https://raw.githubusercontent.com/lixiaomeng8520/arch-install/master/script/install.usb1.sh
wget https://raw.githubusercontent.com/lixiaomeng8520/arch-install/master/script/install.usb2.sh

sh install.usb1.sh
cp install.usb2.sh /mnt
```

## usb - inner

```bash
sh install.usb2.sh
```

## os

```bash
sudo systemctl enable --now NetworkManager
nmtui

sudo pacman -S git
git config --global http.proxy http://192.168.10.3
git config --global https.proxy http://192.168.10.3

git clone https://github.com/lixiaomeng8520/arch-install.git ~/arch-install

sh ~/arch-install/script/install.os.sh
```