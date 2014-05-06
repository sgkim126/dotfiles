from abc import ABCMeta
from abc import abstractmethod
import os
import shutil
import sys

class Config:
    __metaclass__ = ABCMeta
    def __init__(self, *targets):
        self.targets = targets
        pass

    @abstractmethod
    def source_dir(self):
        return os.path.abspath(os.path.curdir)
    @abstractmethod
    def target_dir(self):
        return os.getenv('HOME')

    @abstractmethod
    def source_path(self, target):
        return os.path.join(self.source_dir(), target)
    @abstractmethod
    def target_path(self, target):
        return os.path.join(self.target_dir(), '.' + target)
    @abstractmethod
    def backup_path(self, target):
        return os.path.join(self.target_dir(), target + '.backup')

    @abstractmethod
    def source_exists(self, target):
        if not os.path.exists(self.source_path(target)):
            print("ERROR: {0} is not exist.".format(self.source_path(target)), file=sys.stderr)
            return False
        return True

    @abstractmethod
    def resolve_conflict(self, target):
        if os.path.exists(self.target_path(target)):
            target_path = self.target_path(target)
            backup_path = self.backup_path(target)
            print("ERROR: {0} is already exist.".format(target_path), file=sys.stderr)
            print(" The old {0} will be moved to {1}".format(target_path, backup_path), file=sys.stderr)
            shutil.move(target_path, backup_path)
        return True
    @abstractmethod
    def do(self, target):
        os.symlink(self.source_path(target), self.target_path(target))
    @abstractmethod
    def pre(self):
        pass
    @abstractmethod
    def post(self):
        pass

    def run(self):
        self.pre()
        for target in self.targets:
            if not self.source_exists(target):
                continue
            if not self.resolve_conflict(target):
                continue
            self.do(target)
        self.post()
