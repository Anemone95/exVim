#!/bin/bash

# if [ "$(whoami)" != "root" ]
# then
#     echo "Please run with root!"
#     exit 1
# fi
if [[ $(uname) = "Darwin" ]]; then
    export OS="OSX"
elif grep -q Microsoft /proc/version; then
    export OS="wsl1"
    export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
elif grep -q microsoft /proc/version; then
    export OS="wsl2"
    export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
else
    export OS="linux"
fi

TOOL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
EXVIM_DIR=$TOOL_DIR/..
ln -s -f $EXVIM_DIR/vimfiles/ ~/.vim
ln -s -f $EXVIM_DIR/_vimrc ~/.vimrc
ln -s -f $EXVIM_DIR/_vimrc.plugins ~/.vimrc.plugins
if OS="linux"
    sudo apt-get -y install exuberant-ctags ripgrep
elif OS="OSX"
    brew install ripgrep ctags
fi
# sudo pip3 install jedi
git clone https://github.com/powerline/fonts $TOOL_DIR/fonts
sudo source $TOOL_DIR/fonts/install.sh
