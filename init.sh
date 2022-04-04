#!/bin/bash

ScriptDir=`dirname $(readlink -f "$0")`
echo "script directory: $ScriptDir"

git submodule update --init

cd $ScriptDir/tools
./init_sub.sh