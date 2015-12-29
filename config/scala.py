import config
import os
import shutil
import subprocess


class ConfigScala(config.Config):
    def __init__(self, *targets):
        super().__init__(*targets)
        self.path = os.path.join(os.getenv('HOME'), '.root', 'opt')
        self.address = "https://github.com/scala/scala.git"
        self.name = 'scala'

    def source_dir(self):
        return os.path.join(self.path, 'src', self.name)

    def source_path(self, target):
        return self.source_dir()

    def destination_dir(self):
        return os.path.join(self.path, self.name)

    def destination_path(self, target):
        return self.destination_dir()

    def pre(self):
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
        subprocess.call(['ant', 'build'])
        if os.path.exists(self.destination_dir()):
            os.removedirs(self.destination_dir())
        from_path = os.path.join(self.source_dir(), 'build', 'pack')
        shutil.copytree(from_path, self.destination_dir())
