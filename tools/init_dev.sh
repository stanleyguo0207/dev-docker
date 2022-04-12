#!/bin/bash

# check
if [ ! -d "/root/.vscode-server/data/Machine" ]
then
    echo "init_dev.sh must be executed after vscode uses ssh to connect!!!"
    exit 1
fi

ScriptDir=`dirname $(readlink -f "$0")`
echo "script directory: $ScriptDir"

# core
echo "core pattern set success."
echo "core-%e-%p-%t" > /proc/sys/kernel/core_pattern

# ccls
echo "create ccls cache directory. /opt/docker_home/.cache"
mkdir -p /opt/docker_home/.cache

# vscode
cd $ScriptDir/vscode
echo "vscode IN"

./install-extension.sh
echo "copy remote settings."
cp -f /opt/vscode/vscode-remote.settings.json /root/.vscode-server/data/Machine/settings.json

# node
cd $ScriptDir/node
echo "node IN"

./install-npm.sh
