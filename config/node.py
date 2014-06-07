import config
import os
import subprocess


class ConfigNode(config.Config):
    def __init__(self, *targets):
        super().__init__(*targets)
        self.paths = os.path.join(os.getenv('HOME'), '.root', 'src')
        self.address = "https://github.com/joyent/node.git"
        self.name = self.address.split('/')[-1][:-4]  # node

    def source_dir(self):
        return os.path.join(os.getenv('HOME'), '.root', 'src')

    def source_path(self, target):
        return os.path.join(self.source_dir(), self.name)

    def destination_dir(self):
        return os.path.join(os.getenv('HOME'), '.root', 'lib')

    def destination_path(self, target):
        return os.path.join(self.destination_dir(), self.name)

    def pre(self):
        if not os.path.exists(self.destination_path('node')):
            os.makedirs(self.destination_path('node'))
        if not os.path.exists(self.source_path('node')):
            os.makedirs(self.source_path('node'))
        os.chdir(self.source_path('node'))

    def source_exists(self, target):
        return True

    def resolve_conflict(self, target):
        if not os.path.exists('.git'):
            subprocess.call(['git', 'init'])
        return True

    def do(self, target):
        subprocess.call(['git', 'remote', 'add', 'origin', self.address])
        subprocess.call(['git', 'fetch', 'origin', target + ':' + target])
        subprocess.call(['git', 'checkout', '-b', target, 'tags/' + target])
        prefix = '--prefix=' + self.destination_path('node')
        subprocess.call(['./configure', prefix])
        subprocess.call(['make'])
        subprocess.call(['make', 'install'])
        node_bin = os.path.join(self.destination_path('node'), 'bin', 'node')
        npm_bin = os.path.join(self.destination_path('node'), 'bin', 'npm')
        node_sym = os.path.join(os.getenv('HOME'), '.root', 'bin', 'node')
        npm_sym = os.path.join(os.getenv('HOME'), '.root', 'bin', 'npm')
        os.symlink(node_bin, node_sym)
        os.symlink(npm_bin, npm_sym)
