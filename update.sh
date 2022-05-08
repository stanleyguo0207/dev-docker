#!/bin/bash

ScriptDir=`dirname $(readlink -f "$0")`
echo "script directory: $ScriptDir"

git pull

cd $ScriptDir/tools
./update_sub.sh