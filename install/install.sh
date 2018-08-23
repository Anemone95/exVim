#!/bin/bash

# if [ "$(whoami)" != "root" ]
# then
#     echo "Please run with root!"
#     exit 1
# fi

TOOL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
EXVIM_DIR=$TOOL_DIR/..
ln -s -f $EXVIM_DIR/vimfiles/ ~/.vim
ln -f $EXVIM_DIR/.vimrc ~/.vimrc
ln -f $EXVIM_DIR/.vimrc.local ~/.vimrc.local
ln -f $EXVIM_DIR/.vimrc.plugins ~/.vimrc.plugins
ln -f $EXVIM_DIR/.vimrc.plugins.local ~/.vimrc.plugins.local
sudo apt-get -y install exuberant-ctags gawk id-utils python3-jedi python3-pip
sudo pip3 install jedi
git clone https://github.com/powerline/fonts $TOOL_DIR/fonts
sudo source $TOOL_DIR/fonts/install.sh
