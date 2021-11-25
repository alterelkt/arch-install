#!/bin/bash
set -x
set -e
paru -S zramd
doas vim /etc/default/zramd
doas systemctl enable --now zramd.service
