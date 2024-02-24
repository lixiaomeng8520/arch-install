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

wget 
```

## usb - inner

```bash

```