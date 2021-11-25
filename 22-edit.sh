#!/bin/bash
echo '#permit:wheel' >> /etc/doas.conf
vim /etc/doas.conf
chown -c root:root /etc/doas.conf
chown -c 0400 /etc/doas.conf


printf "\n \n \n In the start 'MODULES=()' to 'MODULES=(btrfs nvidia)' \n In below down 'HOOKS=(...block filesystem...)' to 'HOOKS=(...block encrypt filesystem...)'\n"
while true; do
    read -p "Press Y/y to edit mkinitcpio.conf " yn
    case $yn in
        [Yy]* ) vim /etc/mkinitcpio.conf ; break;;
        [Nn]* ) exit;;
    esac
done
mkinitcpio -p linux

read -p "Enter root partition (eg. sda3) " root_partition
root_UUID=$(blkid -s UUID -o value /dev/${root_partition})
printf '\n \n \n In the start "GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"" to "GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet cryptdevice=UUID=${root_UUID}:cryptroot root=/dev/mapper/cryptroot"" \n for virtual machine only "GRUB_LINUX_CMDLINE_DEFAULT="loglevel=3 quiet cryptdevice=UUID=${root_UUID}:cryptroot root=/dev/mapper/cryptroot video=1920x1080"" \n \n \n Go to last line of the file to copy above syntax \n'

echo "#loglevel=3 quiet cryptdevice=UUID=${root_UUID}:cryptroot root=/dev/mapper/cryptroot" >> /etc/default/grub
while true; do
    read -p "Press Y/y to edit grub " yn
    case $yn in
        [Yy]* ) vim /etc/default/grub ; break;;
        [Nn]* ) exit;;
    esac
done
grub-mkconfig -o /boot/grub/grub.cfg
