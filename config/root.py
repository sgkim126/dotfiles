import config
import os


class ConfigRoot(config.Config):
    def make_if_not_exist(self, path):
        if not os.path.exists(path):
            os.mkdir(path)
    def targets(self):
        return [
            'bin',
            'lib',
            'opt',
            'tmp',
            'var',
        ]
    def target_dir(self):
        return os.path.join(super().target_dir(), '.root')
    def target_path(self, target):
        return os.path.join(self.target_dir(), target)
    def source_exists(self, target):
        return True
    def resolve_conflict(self, target):
        return True
    def pre(self):
        self.make_if_not_exist(self.target_dir())
    def do(self, target):
        self.make_if_not_exist(self.target_path(target))
