#!/bin/bash
cp -r vimfiles/* /usr/share/vim/vimfiles
cp .vimrc* ~/
apt-get -y install exuberant-ctags gawk id-utils python3-jedi
git clone https://github.com/powerline/fonts
source ~/exVim/fonts/install.sh
