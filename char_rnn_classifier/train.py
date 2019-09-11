import subprocess

def bash_command(cmd):
    subprocess.call(cmd, shell=True, executable='/bin/bash')
bash_command(['./train.sh'])

