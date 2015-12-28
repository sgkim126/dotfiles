import config
import urllib.request
import os
import tarfile
import subprocess


class ConfigLibtool(config.Config):
    def __init__(self, *targets):
        super().__init__(*targets)
        self.prefix = os.path.join(os.getenv('HOME'), '.root')
        self.opt = os.path.join(self.prefix, 'opt')
        self.address = "http://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.gz"
        self.tarname = self.address.split('/')[-1]  # libtool-2.4.6.tar.gz
        self.tarpath = os.path.join(self.opt, self.tarname)
        self.name = self.tarname[:-7]  # libtool-2.4.6
        self.path = os.path.join(self.opt, self.name)

    def pre(self):
        if not os.path.exists(self.opt):
            os.makedirs(self.opt)
        os.chdir(self.opt)
        if os.path.exists(self.path):
            return
        if not os.path.exists(self.tarpath):
            urllib.request.urlretrieve(self.address, self.tarname)
            tarfile.open(self.tarname).extractall()

    def source_exists(self, target):
        return True

    def resolve_conflict(self, target):
        return True

    def do(self, target):
        os.chdir(self.path)
        prefix = '--prefix=' + self.prefix
        subprocess.call(['./configure', prefix])
        subprocess.call(['make'])
        subprocess.call(['make', 'install'])
