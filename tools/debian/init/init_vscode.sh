#!/bin/zsh

if [ -L $0 ]
then
    script_dir=`dirname $(readlink $0)`
else
    script_dir=`dirname $0`
fi

vscode_dir="$script_dir/../vscode"

# extension
sh -c "${vscode_dir}/install-extension.sh"

# remote settings
mkdir -p /opt/docker_home/.vscode-server/data/Machine
cp ${vscode_dir}/settings.json /opt/docker_home/.vscode-server/data/Machine/
