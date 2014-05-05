import config
import os
import subprocess


class ConfigApt(config.Config):
    def targets(self):
        return [
            'build-essential',
            'git',
            'irssi',
            'python2.7',
            'python3',
            'ri',
            'ruby',
            'screen',
            'tmux',
            'vim',
        ]
    def source_exists(self, target):
        return True
    def resolve_conflict(self, target):
        return True
    def pre(self):
        subprocess.call(['sudo', 'apt-get', 'update'])
        subprocess.call(['sudo', 'apt-get', 'upgrate'])
    def do(self, target):
        pass
    def post(self):
        subprocess.call(['sudo', 'apt-get', 'install'] + self.targets())
