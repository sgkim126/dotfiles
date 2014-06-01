import config
import os


class ConfigRoot(config.Config):
    def make_if_not_exist(self, path):
        if not os.path.exists(path):
            os.mkdir(path)

    def destination_dir(self):
        return os.path.join(super().destination_dir(), '.root')

    def destination_path(self, target):
        return os.path.join(self.destination_dir(), target)

    def source_exists(self, target):
        return True

    def resolve_conflict(self, target):
        return True

    def pre(self):
        self.make_if_not_exist(self.destination_dir())

    def do(self, target):
        self.make_if_not_exist(self.destination_path(target))
