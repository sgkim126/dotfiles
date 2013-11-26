#!/usr/bin/env bash
CONFIG_PATH=`pwd`/`dirname $0`

function confirm:message() {
MESSAGE=$1
if [[ -n "$MESSAGE" ]]
then
    echo -n "$MESSAGE"
fi
echo -n "(y/n) "
while [ true ]
do
    read -n 1
    if [[ "$REPLY" = [Yy] ]]
    then
        echo ""
        exit 0
    elif [[ "$REPLY" = [Nn] ]]
    then
        echo ""
        exit -1
    fi
done
}

function make_link:target() {
    TARGET=$1
    FROM_PATH="$CONFIG_PATH/xorg.conf.d"
    TO_PATH='/usr/share/X11/xorg.conf.d/'
    PREFIX='90-'
    if [ ! -e $FROM_PATH/$TARGET ]
    then
        echo "ERROR: $FROM_PATH/$TARGET is not exist." 1>&2
        exit -1
    fi
    if [ -e $TO_PATH/$TARGET ]
    then
        TARGET_FILE="$TO_PATH/$TO_PATH/$PREFIX$TARGET"
        echo "ERROR: $TARGET_FILE is already exist." 1>&2
        echo " The old $TARGET_FILE will be copied to $TARGET_FILE.backup." 1>&2
        sudo mv $TARGET_FILE $TARGET_FILE.backup || exit -1
        unset TARGET_FILE
    fi
    sudo ln -s $FROM_PATH/$TARGET $TO_PATH/$PREFIX$TARGET || exit -1
    unset TARGET
    unset FROM_PATH
    unset TO_PATH
}

if (confirm:message 'Do you want to config xorg? It needs a root permision.')
then
    make_link:target evoluent.conf
    make_link:target kensington-slimblade.conf
fi
# vim: set ft=sh
