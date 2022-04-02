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

if [ $# != 4 ]
then
    echo "Usage: createcontainer.sh [container_name] [port] [user_name] [user_id]"
    exit 1
fi

function CreateContainer(){
    docker create --name "$1"_dvc -v /opt/docker_home hello-world:latest
    docker create --name "$1" --volumes-from "$1"_dvc -p "$2":22  --security-opt seccomp=unconfined --privileged=true $ImageName /usr/sbin/init
    docker start $1
    docker cp $ScriptDir/createuser.sh $1:/root
    docker exec -i $1 /bin/bash /root/createuser.sh $3 $4
    echo "create root:root & "$3:$3" two accounts for container $1"
    docker exec -i -u stanley $1 /bin/zsh /opt/docker_home/omz/omz.sh "/opt/docker_home"
    docker cp $ScriptDir/.p10k.zsh $1:/opt/docker_home
    docker cp $ScriptDir/.zshrc $1:/opt/docker_home
    docker exec -it -u stanley $1 /bin/zsh
}

ContainerName=$1
Port=$2
UserName=$3
UserId=$4

CreateContainer $ContainerName $Port $UserName $UserId

# ./createcontainer.sh dev01 9901 stanley 10001