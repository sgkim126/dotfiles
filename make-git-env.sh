#!/usr/bin/env bash
CONFIG_PATH=`pwd`/`dirname $0`

function receive:message() {
MESSAGE=$1
if [[ -n "$MESSAGE" ]]
then
    echo -n "$MESSAGE "
fi
while [ true ]
do
    read -r
    if [ -n "$REPLY" ]
    then
        return
    fi
done
}

function backup:target() {
TARGET=$1
if [ ! -e $CONFIG_PATH/$TARGET ]
then
    echo "ERROR: $CONFIG_PATH/$TARGET is not exist." 1>&2
    unset TARGET
    exit -1
fi
if [ -e $HOME/.$TARGET ]
then
    TARGET_FILE="$HOME/.$TARGET"
    BACKUP_FILE="$HOME/$TARGET.backup"
    echo "ERROR: $TARGET_FILE is already exist." 1>&2
    echo " The old $TARGET_FILE will be copied to $BACKUP_FILE." 1>&2
    mv $TARGET_FILE $BACKUP_FILE || exit -1
    unset TARGET_FILE
    unset BACKUP_FILE
    unset TARGET
fi
}

backup:target gitconfig
cp $CONFIG_PATH/gitconfig $HOME/.gitconfig
backup:target gitignore
ln -s $CONFIG_PATH/gitignore $HOME/.gitignore

if [ ! $(git config --global user.name) ]
then
    receive:message "Enter your name used for git commits."
    git config --global user.name "$REPLY"
fi

if [ ! $(git config --global user.email) ]
then
    receive:message "Enter your mail address used for git commits."
    git config --global user.email "$REPLY"
fi
