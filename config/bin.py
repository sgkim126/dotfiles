import config
import os


class ConfigBin(config.Config):
    def source_dir(self):
        return os.path.join(super().source_dir(), 'bin')

    def destination_dir(self):
        return os.path.join(
            os.path.join(super().destination_dir(), '.root'), 'bin')

    def destination_path(self, target):
        return os.path.join(self.destination_dir(), target)
