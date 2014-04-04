if [ "$PS1" ]; then
    if [ "$BASH" ] && [ "$BASH" != "/bin/sh" ]; then
        # The file bash.bashrc already sets the default PS1.
        # PS1='\h:\w\$ '
        if [ -f /etc/bash.bashrc ]; then
            source /etc/bash.bashrc
        fi
        # include .bashrc if it exists
        if [ -f "$HOME/.bashrc" ]; then
            source "$HOME/.bashrc"
        fi
    elif [ "`id -u`" -eq 0 ]; then
        PS1='# '
    else
        PS1='$ '
    fi
fi

if [ -f "$HOME/.bash_completion" ]
then
    source "$HOME/.bash_completion"
fi

if [ -d "$HOME/.rvm/bin" ] ; then
    export PATH="${PATH}:$HOME/.rvm/bin"
fi

if [ -d "$HOME/.root" ] ; then
    export PREFIX="$HOME/.root"
    if [ -d "$PREFIX/bin" ] ; then
        export PATH="$PREFIX/bin:$PATH"
    fi
    if [ -d "$PREFIX/lib" ] ; then
        export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
    fi
fi

# vim:set ft=sh:
