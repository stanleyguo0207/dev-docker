#!/bin/zsh

# check
if [ ! -d "/root/.vscode-server/data/Machine" ]
then
    echo "init_dev.sh must be executed after vscode uses ssh to connect!!!"
    exit 1
fi

ScriptDir=`dirname $(readlink -f "$0")`
echo "script directory: $ScriptDir"

# git
echo "git global config."
git config --global core.editor vim
git config --global commit.template /root/.config/commit.template

# pip3
echo "pip3 install package."
pip config set global.index-url http://mirrors.aliyun.com/pypi/simple/
pip config set install.trusted-host mirrors.aliyun.com
pip install ranger-fm ueberzug pynvim

# core
echo "core pattern set success."
echo "core-%e-%p-%t" > /proc/sys/kernel/core_pattern

# ccls
echo "create ccls cache directory. /opt/docker_home/.cache"
mkdir -p /opt/docker_home/.cache

# node
cd $ScriptDir/node
echo "node IN"

./install-npm.sh

# vscode
cd $ScriptDir/vscode
echo "vscode IN"

./install-extension.sh
echo "copy remote settings."
cp -f /opt/vscode/vscode-remote.settings.json /root/.vscode-server/data/Machine/settings.json
