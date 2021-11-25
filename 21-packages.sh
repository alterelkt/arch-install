#!/bin/bash
set -x
set -e
pacman -S \
	grub grub-btrfs efibootmgr os-prober \
	intel-ucode base-devel linux-headers \
	smartmontools mtools dosfstools btrfs-progs ntfs-3g \
	xdg-user-dirs xdg-utils \
	git openssh rsync stow \
	opendoas htop wget firewalld cronie nmap \
	networkmanager network-manager-applet wpa_supplicant \
	bluez bluez-utils \
	alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack \
	acpi acpid xf86-input-libinput chrony tlp xf86-input-wacom \
       	nvidia nvidia-utils nvidia-settings nvidia-prime \
	mesa xf86-video-intel \
	vnstat scrot nitrogen reflector \
	vim emacs \
	zsh bash-completion dialog \
	xorg-server xorg-xinit xorg-xrandr xorg-xbacklight xorg-xsetroot \
	android-tools arduino \
	atool p7zip unrar unzip \
	firefox mpv inkscape krita virtualbox \
	ffmpeg imagemagick mediainfo ghostscript gifsicle \
	python python-pip \
	ttf-ubuntu-font-family

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable \
	NetworkManager \
	bluetooth \
	sshd \
	tlp \
	reflector.timer \
	firewalld \
	acpid

