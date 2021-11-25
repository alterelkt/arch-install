#!/bin/bash
set -x
set -e
git clone https://github.com/alterelkt/dwm.git
git clone https://github.com/alterelkt/dmenu.git
git clone https://github.com/alterelkt/st.git

cd dwm
doas make clean install
cd ../dmenu
doas make clean install
cd ../st
doas make clean install
cd ..

