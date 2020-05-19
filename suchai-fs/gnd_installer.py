
import argparse
import subprocess as sp
from pathlib import Path
import os
import time

available_modes = ['SUCHAIFS']
available_archs = ["X86", "GROUNDSTATION", "RPI", "NANOMIND", "ESP32", "AVR32"]
available_envs = ['production', 'test']


class GndInstaller:

    test = False
    st_mode = 1

    def __init__(self, install_folder, arch='X86', pull=True, env='test', node=10):
        self.arch = arch
        self.root = install_folder
        self.sandbox = self.root / 'sandbox'
        self.pull = pull
        self.process_env(env)
        self.node = 10

    def process_env(self, env):
        # production environment
        if env == available_envs[0]:
            self.st_mode = 2

        # test environment
        elif env == available_envs[1]:
            self.st_mode = 1
            self.test = True

    def install_system(self):
        if self.pull:
            out = sp.run(['git', 'pull'], cwd=str(self.root))
            out.check_returncode()

        if self.st_mode == 2:
            # First wait for postgresdb to initialize
            time.sleep(6)
            out = sp.run(['sh', './postgresql_user_setup.sh', '{}'.format(os.environ['USER'])], cwd=str(self.sandbox))
            out.check_returncode()

        # python3 compile.py LINUX X86 --comm 1 --fp 1 --hk 1 --test 0 --st_mode 2 --drivers --node 11
        out = sp.run(['python3', 'compile.py',
                      'LINUX', '{}'.format(self.arch),
                      '--comm', '1',
                      '--fp', '1',
                      '--hk', '1',
                      '--test', '0' if not self.test else '1',
                      '--st_mode', '{}'.format(self.st_mode),
                      '--node', str(self.node),
                      '--drivers'], cwd=str(self.root))
        out.check_returncode()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--arch', type=str, default="X86", choices=available_archs)
    parser.add_argument('--node', type=int, default=10)
    parser.add_argument('--env', type=str, default='test', choices=available_envs)
    args = parser.parse_args()

    test = (args.env == 'test')
    print(Path('./SUCHAI-Flight-Software').absolute())
    gnd = GndInstaller(install_folder=Path('./SUCHAI-Flight-Software'), node=args.node, arch=args.arch, env=args.env)
    gnd.install_system()






