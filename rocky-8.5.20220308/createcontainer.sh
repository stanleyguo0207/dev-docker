#!/bin/bash

ScriptFile=$0
echo "script file: $ScriptFile"
ImageName=dev_rocky:v8.5

if [ -L $0 ]
then
    ScriptDir=`dirname $(readlink $0)`
else
    ScriptDir=`dirname $0`
fi
echo "script directory: $ScriptDir"

if [ $# != 2 ]
then
    echo "Usage: createcontainer.sh [container_name] [port]"
    exit 1
fi

function CreateContainer(){
    docker create --name "$1"_dvc -v /opt/docker_home hello-world:latest
    docker create --name "$1" --volumes-from "$1"_dvc -p "$2":22  --security-opt seccomp=unconfined --privileged=true $ImageName /usr/sbin/init
    docker start $1
    docker exec -it $1 /bin/zsh
    echo "create root:root accounts for container $1 port:$2"
}

ContainerName=$1
Port=$2

CreateContainer $ContainerName $Port

# ./createcontainer.sh dev01 9901