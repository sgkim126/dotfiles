#!/usr/bin/env bash

CONFIG_PATH=`pwd`/`dirname $0`

function make_link:target() {
    TARGET=$1
    if [ ! -e $CONFIG_PATH/$TARGET ]
    then
        echo "ERROR: $CONFIG_PATH/$TARGET is not exist." 1>&2
        exit -1
    fi
    if [ -e $HOME/.$TARGET ]
    then
        echo "ERROR: $HOME/.$TARGET is already exist." 1>&2
        echo " The old $HOME/.$TARGET will be copied to $HOME/$TARGET.backup" 1>&2
        mv $HOME/.$TARGET $HOME/$TARGET.backup || exit -1
    fi
    ln -s $CONFIG_PATH/$TARGET $HOME/.$TARGET || exit -1
    unset TARGET
}

make_link:target bashrc
make_link:target profile
make_link:target subversion
make_link:target tmux.conf
make_link:target screenrc
make_link:target irssi

bash make-git-env.sh
bash make-xorg-env.sh

if [ -e $HOME/.root ]
then
    echo "ERROR: $HOME/.root is already exist." 1>&2
    echo " The old $HOME/.root will be copied to $HOME/root.backup" 1>&2
fi

mkdir $HOME/.root
mkdir $HOME/.root/lib
mkdir $HOME/.root/bin
# vim: set ft=sh
