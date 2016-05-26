#!/bin/
cd ~/exVim*
cp -r vimfiles/* /usr/share/vim/vimfiles
mv .vimrc* ~/
apt-get -y install exuberant-ctags gawk id-utils
git clone https://github.com/powerline/fonts
source ../fonts/install.sh
