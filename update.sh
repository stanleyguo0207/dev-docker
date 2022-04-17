#!/bin/bash

ScriptDir=`dirname $(readlink -f "$0")`
echo "script directory: $ScriptDir"

git submodule update --remote

cd $ScriptDir/tools
./update_sub.sh