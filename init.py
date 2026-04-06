#!/usr/bin/env python3
from functools import partial
import os
import subprocess
import sys
import tarfile
import traceback
import urllib.request


HOME = os.getenv('HOME')
PREFIX = os.path.join(HOME, '.root')
OPT_PATH = os.path.join(PREFIX, 'opt')
BIN_PATH = os.path.join(PREFIX, 'bin')


def try_and_catch(function):
    try:
        function()
    except Exception as ex:
        print(ex)
        traceback.print_exc(file=sys.stdout)


def apt_install(*packages):
    def apt_internal():
        if not confirm('Do you want to install packages with sudo?(y/n) '):
            return
        subprocess.call(['sudo', 'apt-get', 'update'])
        subprocess.call(['sudo', 'apt-get', 'upgrade', '-y'])
        apt_get_command_without_target = ['sudo', 'apt-get', 'install', '-y']
        for package in packages:
            subprocess.call(apt_get_command_without_target + package)
    try_and_catch(apt_internal)


def initialize_root():
    def initialize_root_internal():
        question = 'Do you want to initialize $HOME/.root directory? (y/n) '
        if not confirm(question):
            return

        dirs = [
            BIN_PATH,
            os.path.join(PREFIX, 'include'),
            os.path.join(PREFIX, 'lib'),
            OPT_PATH,
            os.path.join(PREFIX, 'tmp'),
            os.path.join(PREFIX, 'var'),
            os.path.join(PREFIX, 'share', 'doc'),
            os.path.join(PREFIX, 'share', 'info'),
            os.path.join(PREFIX, 'share', 'man')]

        for dir in dirs:
            os.makedirs(dir, exist_ok=True)

    try_and_catch(initialize_root_internal)


def config_git():
    def config_git_internal():
        if not confirm('Do you want to config git? (y/n) '):
            return

        def global_config(attribute, value):
            subprocess.call(['git', 'config', '--global'] + [attribute, value])

        global_config('color.ui', 'auto')
        global_config('color.ui', 'auto')
        global_config('core.editor', 'vim')
        global_config('core.excludesfile', '~/.gitignore')
        global_config('diff.noprefix', 'true')
        global_config('init.defaultBranch', 'main')

        name = input("Enter your name for git: ")
        if name != '':
            global_config('user.name', name)
        mail = input("Enter your mail address for git: ")
        if mail != '':
            global_config('user.email', mail)
        username = input("Enter your github username: ")
        if username != '':
            global_config('github.user', username)
    try_and_catch(config_git_internal)


def clone_git_repository(path, url):
    os.makedirs(path, exist_ok=True)
    os.chdir(path)
    if not os.path.exists('./.git'):
        subprocess.call(['git', 'init'])
        subprocess.call(['git', 'remote', 'add', 'origin', url])
    subprocess.call(['git', 'fetch', 'origin'])
    subprocess.call(['git', 'reset', '--hard', 'origin/master'])


def config_vim():
    def config_vim_internal():
        if not confirm('Do you want to config vim? (y/n) '):
            return

        url = 'https://github.com/sgkim126/dotvim.git'
        dotvim_path = os.path.join(HOME, '.vim')
        clone_git_repository(dotvim_path, url)

        dotvimrc_path = os.path.join(HOME, '.vimrc')
        vimrc_path = os.path.join(dotvim_path, 'vimrc')

        if os.path.exists(dotvimrc_path):
            os.remove(dotvimrc_path)
        os.symlink(vimrc_path, dotvimrc_path)

        subprocess.call(['vim', '+PlugInstall', '+qall'])

    try_and_catch(config_vim_internal)


def config_home():
    def config_home_internal():
        if not confirm('Do you want to config home? (y/n) '):
            return
        OPT_PATH = os.path.join(PREFIX, 'opt')
        dotfiles_path = os.path.join(OPT_PATH, 'dotfiles')
        url = 'https://github.com/sgkim126/dotfiles.git'
        clone_git_repository(dotfiles_path, url)
        dothome = os.path.join(dotfiles_path, 'home')
        files = os.listdir(dothome)
        for file in files:
            filename = '.%s' % file
            symfile = os.path.join(HOME, filename)
            if os.path.exists(symfile):
                os.remove(symfile)
            os.symlink(os.path.join(dothome, file), symfile)

    try_and_catch(config_home_internal)


def confirm(message):
    while True:
        i = input(message)
        if i == 'y':
            return True
        if i == 'n':
            return False


if __name__ == '__main__':
    apt_install('build-essential', 'curl', 'file', 'git')

    initialize_root()

    config_home()
    config_git()
    config_vim()
