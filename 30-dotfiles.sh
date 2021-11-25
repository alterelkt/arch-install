#!/bin/bash
set -x
set -e
cd ~
git clone https://github.com/alterelkt/.dotfiles.git
cd .dotfiles
stow -v -t ~/ -d */
cd ..
