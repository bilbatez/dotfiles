#!/bin/sh
sudo ip link set wlan0 up
echo "wireless network interface is up!"

sudo vim /etc/conf.d/wireless-regdom
echo "wireless regdb updated!"

sudo iw reg set SG
echo "wireless regdom updated!"

sudo mkswap -U clear --size 8G --file /swapfile
sudo cryptsetup luksFormat /swapfile
sudo cryptsetup open /swapfile cryptswap
sudo mkswap /dev/mapper/cryptswap
sudo swapon /dev/mapper/cryptswap
sudo "\n\n#Swapfile\n/dev/mapper/cryptswap none swap sw 0 0\n" >> /etc/fstab
sudo "\n\n#Swapfile\ncryptswap /swapfile none luks\n" >> /etc/crypttab
echo "swapfile created!"
