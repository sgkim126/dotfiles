#!/usr/bin/env python3
import config.ant
import config.apt
import config.bin
import config.cmake
import config.curl
import config.git
import config.gitbin
import config.home
import config.libtool
import config.libxml2
import config.node
import config.root
import config.sbt
import config.scala
import config.vim
import config.virtualenv
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
            config.apt.ConfigApt(
                'build-essential',
                'clang',
                'cmake',
                'libpython2.7-dev'
            ).run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to config Xorg with sudo?(y/n) '):
            config.xorg.ConfigXorg(
                'evoluent.conf',
                'kensington-slimblade.conf'
            ).run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to create $HOME/.root directory?(y/n) '):
            config.root.ConfigRoot(
                'bin',
                'lib',
                'opt',
                'tmp',
                'var',
            ).run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to config bin?(y/n) '):
            config.bin.ConfigBin('git-new-workdir').run()
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
        if confirm('Do you want to config git?(y/n) '):
            config.git.ConfigGit(
                'gitconfig',
                'gitignore'
            ).run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to config vim?(y/n) '):
            config.vim.ConfigVim('vimrc').run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to config Xorg with sudo?(y/n) '):
            config.xorg.ConfigXorg(
                'evoluent.conf',
                'kensington-slimblade.conf'
            ).run()
    except Exception as ex:
        print(ex)
    try:
        if confirm('Do you want to install virtualenv?(y/n) '):
            config.virtualenv.ConfigVirtualenv('1.11.6').run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to install ant?(y/n) '):
            config.ant.ConfigAnt('ANT_194').run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to install scala?(y/n) '):
            config.scala.ConfigScala('v2.11.2').run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to install cmake?(y/n) '):
            config.cmake.ConfigCmake('v3.4.1').run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to install libtool?(y/n) '):
            config.libtool.ConfigLibtool('v2.4.6').run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to install curl?(y/n) '):
            config.curl.ConfigCurl('curl-7_46_0').run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to install git?(y/n) '):
            config.gitbin.ConfigGit('v2.6.4').run()
    except Exception as ex:
        print(ex)

    try:
        if confirm('Do you want to install node?(y/n) '):
            config.node.ConfigNode('v5.3.0').run()
    except Exception as ex:
        print(ex)
