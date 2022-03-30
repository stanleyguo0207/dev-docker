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

if [ $# != 2]
then
    echo "Usage: createcontainer.sh [container_name] [port]"
    exit 1
fi

function CreateContainer(){
    docker create --name "$1"_dvc -v /opt/docker_home hello-world:latest
    docker create --name "$1" --volumes-from "$1"_dvc -p "$2":22 --security-opt seccomp=unconfined --privileged=true $ImageName /usr/sbin/init
    docker start $1
    docker cp $ScriptDir/createuser.sh $1:/root
    docker exec -it $1 /bin/zsh /root/createuser.sh $1 $2
    echo "create root:root & "$1:$1" two accounts for container $1"
}

ContainerName=$1
Port=$2

CreateContainer $ContainerName $Port