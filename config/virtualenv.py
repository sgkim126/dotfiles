import config
import os
import subprocess


class ConfigVirtualenv(config.Config):
    def __init__(self, *targets):
        super().__init__(*targets)
        self.paths = os.path.join(os.getenv('HOME'), '.root', 'usr')
        self.address = "https://github.com/pypa/virtualenv.git"
        self.name = self.address.split('/')[-1][:-4]  # virtualenv

    def pre(self):
        os.chdir(self.paths)

    def source_exists(self, target):
        return True

    def resolve_conflict(self, target):
        if not os.path.exists(self.name):
            os.mkdir(self.name)
        os.chdir(self.name)
        if not os.path.exists('.git'):
            subprocess.call(['git', 'init'])
        return True

    def do(self, target):
        subprocess.call(['git', 'remote', 'add', 'origin', self.address])
        subprocess.call(['git', 'fetch', 'origin', target + ':' + target])
        subprocess.call(['git', 'checkout', '-b', target, 'tags/' + target])
        fullPath = os.path.join(
            os.path.join(self.paths, self.name), 'virtualenv.py')
        destination = os.path.join(
            os.getenv('HOME'), '.root', 'bin', 'virtualenv.py')
        os.symlink(fullPath, destination)
