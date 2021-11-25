#!/bin/bash
set -x
set -e
doas pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin/
makepkg -si
cd ..
rm -rf ./paru-bin
