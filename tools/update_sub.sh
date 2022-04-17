#!/bin/bash

ScriptDir=`dirname $(readlink -f "$0")`
echo "script directory: $ScriptDir"

# ccls
cd $ScriptDir/ccls
echo "submodule ccls IN"

git submodule update --remote

# omz
cd $ScriptDir/omz
echo "submodule omz IN"

git submodule update --remote

# nodejs
cd $ScriptDir/nodejs
echo "nodejs IN"

if [ ! -f "$ScriptDir/nodejs/node-v17.9.0-linux-x64.tar.xz" ]
then
    curl -O https://nodejs.org/download/release/v17.9.0/node-v17.9.0-linux-x64.tar.xz
fi
