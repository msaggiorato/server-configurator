#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo ':: Setting up SWAP'
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab

echo "vm.swappiness=10" >> /etc/sysctl.d/99-better-swap.conf
echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.d/99-better-swap.conf