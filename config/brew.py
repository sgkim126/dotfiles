import config
import os
import subprocess


class ConfigBrew(config.Config):
    def __init__(self, *targets):
        super().__init__("https://github.com/Homebrew/linuxbrew.git")
        self.paths = os.path.join(os.getenv('HOME'), '.linuxbrew')

    def source_exists(self, target):
        return True

    def resolve_conflict(self, target):
        if not os.path.exists(self.paths):
            os.mkdir(self.paths)
        os.chdir(self.paths)
        if not os.path.exists('.git'):
            subprocess.call(['git', 'init'])
        return True

    def do(self, target):
        subprocess.call(['git', 'remote', 'add', 'origin', target])
        subprocess.call(['git', 'fetch', 'origin', 'master'])
        subprocess.call(['git', 'checkout', '-b', 'master', 'origin/master'])
