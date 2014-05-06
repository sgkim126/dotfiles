import config
import os


class ConfigBin(config.Config):
    def source_dir(self):
        return os.path.join(super().source_dir(), 'bin')
    def target_dir(self):
        return os.path.join(os.path.join(super().target_dir(), '.root'), 'bin')
    def target_path(self, target):
        return os.path.join(self.target_dir(), target)

