#!/bin/bash
set -x -o pipefail

umount /dev/mmcblk1*
cat <<EOP | fdisk /dev/mmcblk1
g
w
EOP
cgpt create /dev/mmcblk1
cgpt add -i 1 -t kernel -b 8192 -s 65536 -l Kernel -S 1 -T 5 -P 10 /dev/mmcblk1

sz=$(cgpt show /dev/mmcblk1 | sed -e '/Sec GPT table/!d' | awk '{print $1}')
cgpt add -i 2 -t data -b 73728 -s $(expr $sz - 73728) -l Root /dev/mmcblk1
partx -a /dev/mmcblk1
mkfs.ext4 /dev/mmcblk1p2

cd /tmp
curl -LO http://os.archlinuxarm.org/os/ArchLinuxARM-gru-latest.tar.gz
mkdir rootfs
mount /dev/mmcblk1p2 rootfs
tar -xf ArchLinuxARM-gru-latest.tar.gz -C rootfs

curl -LO https://bitbucket.org/bikochan/c101pa/downloads/setup.sh
chmod +x setup.sh
mv setup.sh rootfs/root/setup.sh


dd if=root/boot/vmlinux.kpart of=/dev/mmcblk1p1
sync
umount rootfs
