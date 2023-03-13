#!/bin/bash

ScriptDir=`dirname $(readlink -f "$0")`
echo "script directory: $ScriptDir"

git submodule update --remote

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
