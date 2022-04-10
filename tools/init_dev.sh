#!/bin/bash

ScriptDir=`dirname $(readlink -f "$0")`
echo "script directory: $ScriptDir"

# core
echo "core pattern set success."
echo "core-%e-%p-%t" > /proc/sys/kernel/core_pattern

# vscode
cd $ScriptDir/vscode
echo "vscode IN"

./install-extension.sh

# node
cd $ScriptDir/node
echo "node IN"

./install-npm.sh
