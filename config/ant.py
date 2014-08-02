import config
import os
import subprocess


class ConfigAnt(config.Config):
    def __init__(self, *targets):
        super().__init__(*targets)
        self.path = os.path.join(os.getenv('HOME'), '.root', 'opt')
        self.address = "https://github.com/apache/ant.git"
        self.name = 'ant'

    def source_dir(self):
        return os.path.join(self.path, 'src', self.name)

    def source_path(self, target):
        return self.source_dir()

    def destination_dir(self):
        return os.path.join(self.path, self.name)

    def destination_path(self, target):
        return self.destination_dir()

    def pre(self):
        if not os.path.exists(self.destination_dir()):
            os.makedirs(self.destination_dir())
        if not os.path.exists(self.source_dir()):
            os.makedirs(self.source_dir())
        os.chdir(self.source_dir())
        if not os.path.exists('.git'):
            subprocess.call(['git', 'init'])
            subprocess.call(['git', 'remote', 'add', 'origin', self.address])

    def source_exists(self, target):
        return True

    def resolve_conflict(self, target):
        return True

    def do(self, target):
        subprocess.call(['git', 'fetch', 'origin', target + ':' + target])
        subprocess.call(['git', 'checkout', '-b', target, 'tags/' + target])
        env = os.environ
        env['ANT_HOME'] = self.destination_dir()
        subprocess.Popen(['./build.sh', 'install-lite'], env=env)
        ant_bin = os.path.join(self.destination_dir(), 'bin', 'ant')
        ant_sym = os.path.join(os.getenv('HOME'), '.root', 'bin', 'ant')
        os.symlink(ant_bin, ant_sym)
