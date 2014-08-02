import config
import subprocess


class ConfigApt(config.Config):
    def source_exists(self, target):
        return True

    def resolve_conflict(self, target):
        return True

    def pre(self):
        subprocess.call(['sudo', 'apt-get', 'update'])
        subprocess.call(['sudo', 'apt-get', 'upgrade', '-y'])

    def do(self, target):
        pass

    def post(self):
        apt_get_command_without_target = ['sudo', 'apt-get', 'install', '-y']
        subprocess.call(apt_get_command_without_target + list(self.targets))
