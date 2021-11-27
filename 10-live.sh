#!/bin/bash
set -x
set -e
timedatectl set-ntp true

lsblk
read -p "Enter device (eg. sda) " device_to_install
gdisk /dev/${device_to_install}
boot_partition=${device_to_install}1
root_partition=${device_to_install}2

cryptsetup luksFormat /dev/${root_partition}
cryptsetup luksOpen /dev/${root_partition} cryptroot

mkfs.btrfs /dev/mapper/cryptroot
mkfs.vfat /dev/${boot_partition}

mount /dev/mapper/cryptroot /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
umount /mnt

mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/mapper/cryptroot /mnt
mkdir /mnt/{boot,home,var}
mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/cryptroot /mnt/home
mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@var /dev/mapper/cryptroot /mnt/var
mount /dev/${boot_partition} /mnt/boot

mkdir /media/backup
mkdir /media/storage
#mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@backupsubvol /dev/mapper/cryptbackup /backup
#mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@storagesubvol /dev/mapper/cryptstorage /storage

pacstrap /mnt base linux linux-firmware intel-ucode btrfs-progs git wget unzip vim

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
