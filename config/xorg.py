import config
import os
import subprocess


class ConfigXorg(config.Config):
    def source_dir(self):
        return os.path.join(super().source_dir(), 'xorg')

    def destination_dir(self):
        return '/usr/share/X11/xorg.conf.d/'

    def destination_path(self, target):
        return os.path.join(self.destination_dir(), '80-' + target)

    def backup_path(self, target):
        return os.path.join(self.destination_dir(), '90-' + target + '.backup')

    def do(self, target):
        subprocess.call(['sudo', 'ln', '-s', self.source_path(target), self.destination_path(target)])
