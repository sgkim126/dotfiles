import config
import os


class ConfigHome(config.Config):
    def targets(self):
        return [
            'bashrc',
            'ctags',
            'irssi',
            'profile',
            'screenrc',
            'subversion',
            'tmux.conf',
        ]
    def source_dir(self):
        return os.path.join(super().source_dir(), 'home')

