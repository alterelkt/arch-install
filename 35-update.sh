#!/bin/bash
set -x
set -e
doas timedatectl set-ntp true
doas hwclock --systohc

doas cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
doas reflector --latest 30 --sort rate --save /etc/pacman.d/mirrorlist

sudo pacman -Syy
