import config
import os
import subprocess


class ConfigCurl(config.Config):
    def __init__(self, *targets):
        super().__init__(*targets)
        self.address = "https://github.com/bagder/curl.git"
        self.name = self.address.split('/')[-1][:-4]  # curl
        self.prefix = os.path.join(os.getenv('HOME'), '.root')
        self.opt = os.path.join(self.prefix, 'opt')
        self.path = os.path.join(self.opt, self.name)

    def pre(self):
        if not os.path.exists(self.path):
            os.makedirs(self.path)
        os.chdir(self.path)
        if not os.path.exists('.git'):
            subprocess.call(['git', 'init'])
            subprocess.call(['git', 'remote', 'add', 'origin', self.address])

    def source_exists(self, target):
        return True

    def resolve_conflict(self, target):
        return True

    def do(self, target):
        subprocess.call(['git', 'fetch', 'origin', '--tags'])
        subprocess.call(['git', 'checkout', '-b', target, 'tags/' + target])
        prefix = '--prefix=' + self.prefix
        subprocess.call(['./buildconf'])
        subprocess.call(['./configure', prefix])
        subprocess.call(['make'])
        subprocess.call(['make', 'install'])
