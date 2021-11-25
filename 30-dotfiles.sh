#!/bin/bash
set -x
set -e
cd ~
git clone https://github.com/alterelkt/.dotfiles.git
cd .dotfiles
stow --adopt -v -t ~ */
cd ..
