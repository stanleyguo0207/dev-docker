#!/bin/bash

ScriptDir=`dirname $(readlink -f "$0")`
echo "script directory: $ScriptDir"

# vscode
cd $ScriptDir/vscode
echo "vscode IN"

./install-extension.sh

# node
cd $ScriptDir/node
echo "node IN"

./install-npm.sh
