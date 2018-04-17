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
apt-get -y install exuberant-ctags gawk id-utils python3-jedi
git clone https://github.com/powerline/fonts
source $EXVIM_DIR/fonts/install.sh
