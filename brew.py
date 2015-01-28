#!/usr/bin/env python3
import config.package

def confirm(message):
    while True:
        i = input(message)
        if i == 'y':
            return True
        if i == 'n':
            return False

if __name__ == '__main__':
    try:
        if (confirm('Do you want to install bash-completion?(y/n) ')):
            config.package.ConfigPackage('bash-completion').run()

        if (confirm('Do you want to install ack?(y/n) ')):
            config.package.ConfigPackage('ack').run()
        if (confirm('Do you want to install ctags?(y/n) ')):
            config.package.ConfigPackage('ctags').run()

        if (confirm('Do you want to install gcc?(y/n) ')):
            config.package.ConfigPackage('gcc').run()
        if (confirm('Do you want to install llvm?(y/n) ')):
            config.package.ConfigPackage('llvm').run()

        if (confirm('Do you want to install jdk?(y/n) ')):
            config.package.ConfigPackage('jdk').run()
        if (confirm('Do you want to install jdk7?(y/n) ')):
            config.package.ConfigPackage('jdk7').run()

        if (confirm('Do you want to install scala?(y/n) ')):
            config.package.ConfigPackage('scala').run()
        if (confirm('Do you want to install sbt?(y/n) ')):
            config.package.ConfigPackage('sbt').run()

        if (confirm('Do you want to install node?(y/n) ')):
            config.package.ConfigPackage('node').run()

        if (confirm('Do you want to install python?(y/n) ')):
            config.package.ConfigPackage('python').run()

        if (confirm('Do you want to install ruby?(y/n) ')):
            config.package.ConfigPackage('ruby').run()

        if (confirm('Do you want to install tmux?(y/n) ')):
            config.package.ConfigPackage('tmux').run()
    except Exception as ex:
        print(ex)
