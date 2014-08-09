import config
import os
import shutil
import stat
import subprocess
import tarfile
import urllib.request


class ConfigSbt(config.Config):
    def __init__(self, *targets):
        super().__init__(*targets)
        self.path = os.path.join(os.getenv('HOME'), '.root', 'opt')
        self.address = 'https://github.com/sbt/sbt.git'
        self.name = 'sbt'

    def source_dir(self):
        return os.path.join(self.path, self.name)

    def source_path(self, target):
        return self.source_dir()

    def destination_dir(self):
        return os.path.join(os.getenv('HOME'), '.root', 'bin', self.name)

    def destination_path(self, target):
        return self.destination_dir()

    def bootstrap_dir(self):
        return os.path.join(self.source_dir(), 'bootstrap')

    def pre(self):
        if not os.path.exists(self.source_dir()):
            os.makedirs(self.source_dir())
        if not os.path.exists(self.bootstrap_dir()):
            os.makedirs(self.bootstrap_dir())
        os.chdir(self.bootstrap_dir())

        bootstrap_tgz_url = ('http://dl.bintray.com'
                             '/sbt/native-packages/sbt/0.13.5/sbt-0.13.5.tgz')
        bootstrap_tgz_file_name = bootstrap_tgz_url.split('/')[-1]

        if not os.path.exists(bootstrap_tgz_file_name):
            f = open(bootstrap_tgz_file_name, 'b+w')
            f.write(urllib.request.urlopen(bootstrap_tgz_url).read())
            tarfile.open(bootstrap_tgz_file_name).extractall()

        os.chdir(self.source_dir())
        if not os.path.exists('.git'):
            subprocess.call(['git', 'init'])
            subprocess.call(['git', 'remote', 'add', 'origin', self.address])

    def post(self):
        shutil.rmtree(self.bootstrap_dir())

    def source_exists(self, target):
        return True

    def resolve_conflict(self, target):
        return True

    def do(self, target):
        subprocess.call(['git', 'fetch', 'origin', target + ':' + target])
        subprocess.call(['git', 'checkout', '-b', target, 'tags/' + target])
        bootstrap_sbt = os.path.join(self.bootstrap_dir(), 'sbt', 'bin', 'sbt')
        subprocess.call([bootstrap_sbt, 'packageBin'])

        if os.path.exists(self.destination_dir()):
            os.remove(self.destination_dir())
        f = open(self.destination_dir(), 'w')
        version = target[1:]
        f.write(self.sbt_script(version))
        f.close()
        os.chmod(self.destination_dir(), stat.S_IRUSR | stat.S_IXUSR)

    def sbt_script(self, version):
        header = '#/usr/bin/env bash'
        sbt_opts = ('SBT_OPTS="-Xms512M -Xmx1536M -Xss1M'
                    ' -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"')
        java = ('java $SBT_OPTS -jar ' +
                self.source_dir() + '/target/sbt-launch-' + version + '.jar')
        return os.linesep.join([header, sbt_opts, java])
