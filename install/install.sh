#!/bin/bash

if [ "$(whoami)" != "root" ]
then
    echo "Please run with root!"
    exit 1
fi

TOOL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
EXVIM_DIR=$TOOL_DIR/..
cp -r $EXVIM_DIR/vimfiles/* /usr/share/vim/vimfiles
cp $EXVIM_DIR/.vimrc* ~/
apt-get -y install exuberant-ctags gawk id-utils python3-jedi python3-pip
pip3 install jedi
git clone https://github.com/powerline/fonts
source $TOOL_DIR/fonts/install.sh
source $TOOL_DIR/../fonts/install.sh
