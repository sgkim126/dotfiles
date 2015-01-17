import config
import os
import subprocess


class ConfigPackage(config.Config):
    def source_exists(self, target):
        return os.path.join(self.destination_dir(), '.linuxbrew')

    def resolve_conflict(self, target):
        return True

    def do(self, target):
        subprocess.call(['brew', 'install', target])
