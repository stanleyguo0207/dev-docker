#!/bin/bash

ScriptDir=`dirname $(readlink -f "$0")`
echo "script directory: $ScriptDir"

cd $ScriptDir/ccls
echo "submodule ccls IN"

sed -e 's|github.com/Tencent/rapidjson|gitee.com/stanleyguo0207/rapidjson|g' \
        -i .gitmodules
git submodule sync
git submodule update --init

cd $ScriptDir/omz
echo "submodule omz IN"

git submodule update --init
