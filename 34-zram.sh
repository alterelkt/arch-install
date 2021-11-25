#!/bin/bash
set -x
set -e
doas vim /etc/default/zramd
doas systemctl enable --now zramd.service
