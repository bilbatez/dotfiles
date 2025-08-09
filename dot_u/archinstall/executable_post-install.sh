#!/bin/sh
# Run this script post Arch Installation
sudo ip link set wlan0 up
echo "wireless network interface is up!"

sudo vim /etc/conf.d/wireless-regdom
echo "wireless regdb updated!"

sudo iw reg set SG
echo "wireless regdom updated!"

sudo dd if=/dev/urandom of=/etc/cryptsetup-keys.d/cryptswap.key bs=1024 count=4
sudo chmod 0400 /etc/cryptsetup-keys.d/cryptswap.key
echo "swapfile keyfile created!"

sudo mkswap -U clear --size 16G --file /swapfile
sudo cryptsetup luksFormat /swapfile
sudo cryptsetup open /swapfile cryptswap
sudo mkswap /dev/mapper/cryptswap
sudo swapon /dev/mapper/cryptswap
echo "swapfile created!"

sudo cryptsetup luksAddKey /swapfile /etc/cryptsetup-keys.d/cryptswap.key
sudo "\n\n#Swapfile\ncryptswap /swapfile /etc/cryptsetup-keys.d/cryptswap.key luks\n" >> /etc/crypttab
sudo "\n\n#Swapfile\n/dev/mapper/cryptswap none swap defaults 0 0\n" >> /etc/fstab
sudo mkinitcpio -P
echo "swapfile configured!"

echo "Reboot Recommended!"
