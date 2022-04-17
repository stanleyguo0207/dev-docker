#!/bin/bash

ScriptDir=`dirname $(readlink -f "$0")`
echo "script directory: $ScriptDir"

# ccls
cd $ScriptDir/ccls
echo "submodule ccls IN"

sed -e 's|github.com/Tencent/rapidjson|gitee.com/stanleyguo0207/rapidjson|g' \
        -i .gitmodules
git submodule sync
git submodule update --init

# omz
cd $ScriptDir/omz
echo "submodule omz IN"

git submodule update --init

# nodejs
cd $ScriptDir/nodejs
echo "nodejs IN"

curl -O https://nodejs.org/download/release/v17.9.0/node-v17.9.0-linux-x64.tar.xz