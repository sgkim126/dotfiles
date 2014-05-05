#!/usr/bin/env python
import config.apt
import config.bin
import config.git
import config.home
import config.root
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
        if confirm('Do you want to install packages with sudo?(y/n) '):
            config.apt.ConfigApt().run()
    except Exception as ex:
        print(ex)
    try:
        if confirm('Do you want to create $HOME/.root directory?(y/n) '):
            config.root.ConfigRoot().run()
    except Exception as ex:
        print(ex)
    try:
        if confirm('Do you want to config bin?(y/n) '):
            config.bin.ConfigBin().run()
    except Exception as ex:
        print(ex)
    try:
        if confirm('Do you want to config home?(y/n) '):
            config.home.ConfigHome().run()
    except Exception as ex:
        print(ex)
    try:
        if confirm('Do you want to config git?(y/n) '):
            config.git.ConfigGit().run()
    except Exception as ex:
        print(ex)
    try:
        if confirm('Do you want to config vim?(y/n) '):
            config.vim.ConfigVim().run()
    except Exception as ex:
        print(ex)
    try:
        if confirm('Do you want to config Xorg with sudo?(y/n) '):
            config.xorg.ConfigXorg().run()
    except Exception as ex:
        print(ex)
