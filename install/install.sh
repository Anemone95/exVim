#!/bin/bash

# if [ "$(whoami)" != "root" ]
# then
#     echo "Please run with root!"
#     exit 1
# fi

TOOL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
EXVIM_DIR=$TOOL_DIR/..
ln -s -f $EXVIM_DIR/vimfiles/ ~/.vim
ln -f $EXVIM_DIR/_vimrc ~/.vimrc
ln -f $EXVIM_DIR/_vimrc.plugins ~/.vimrc.plugins
sudo apt-get -y install exuberant-ctags ripgrep
# sudo pip3 install jedi
git clone https://github.com/powerline/fonts $TOOL_DIR/fonts
sudo source $TOOL_DIR/fonts/install.sh
