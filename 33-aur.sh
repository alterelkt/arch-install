#!/bin/bash
set -x
set -e
paru -S timeshift-bin
paru -S \
	timeshift-autosnap \
	brave-bin \
	nerd-fonts-jetbrains-mono \
	picom-ibhagwan-git \
	ipscan
