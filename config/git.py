import config
import os
import shutil
import subprocess


class ConfigGit(config.Config):
    def source_dir(self):
        return os.path.join(super().source_dir(), 'home')

    def post(self):
        if subprocess.call(['git', 'config', '--global', 'user.name']):
            while True:
                name = input("Enter your name for git: ")
                if name != '':
                    break
            subprocess.call(['git', 'config', '--global', 'user.name', name])
        if subprocess.call(['git', 'config', '--global', 'user.email']):
            while True:
                mail = input("Enter your mail address for git: ")
                if mail != '':
                    break
            subprocess.call(['git', 'config', '--global', 'user.email', mail])

    def do(self, target):
        shutil.copy(self.source_path(target), self.destination_path(target))
