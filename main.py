#!/usr/bin/env python3
import config.home
import config.vim
import config.xorg


def confirm(message):
    while True:
        i = input(message)
        if i == 'y':
            return True
        if i == 'n':
            return False


if __name__ == '__main__':
    try:
        if confirm('Do you want to config Xorg with sudo?(y/n) '):
            config.xorg.ConfigXorg(
                'evoluent.conf',
                'kensington-slimblade.conf'
            ).run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to config home?(y/n) '):
            config.home.ConfigHome(
                'bashrc',
                'ctags',
                'irssi',
                'profile',
                'screenrc',
                'subversion',
                'tmux.conf'
            ).run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to config vim?(y/n) '):
            config.vim.ConfigVim('vimrc').run()
    except Exception as ex:
        print(ex)
