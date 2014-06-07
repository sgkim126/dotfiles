import config
import os


class ConfigHome(config.Config):
    def source_dir(self):
        return os.path.join(super().source_dir(), 'home')
