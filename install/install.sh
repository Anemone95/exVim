#!/bin/
cd ~/exVim*
cp -r vimfiles/* /usr/share/vim/vimfiles
mv .vimrc* ~/
git clone https://github.com/powerline/fonts
source fonts/install.sh
