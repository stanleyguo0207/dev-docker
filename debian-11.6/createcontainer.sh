#!/bin/bash

if [ $# != 3 ]
then
    echo "Usage: createcontainer.sh [image_name:tag_name] [container_name] [port]"
    exit 1
fi

ScriptFile="$0"
if [ -L $0 ]
then
    ScriptDir=`dirname $(readlink $0)`
else
    ScriptDir=`dirname $0`
fi
ImageName="$1"
ContainerName="$2"
Port=$3

function CreateContainer(){
    docker create --name "$2"_dvc -v /opt/docker_home hello-world:latest
    docker create --name "$2" --volumes-from "$2"_dvc -p "$3":22  --security-opt seccomp=unconfined --privileged=true --restart=always "$1" /sbin/init
    docker start $2
    docker cp $ScriptDir/createuser.sh $_name:/root
    docker cp $ScriptDir/init.sh $_name:/opt/docker_home
    docker cp $ToolsDir/gdbinit.tar.gz $_name:/opt/docker_home
    docker exec -it $2 /bin/bash /root/createuser.sh $2 $3
    echo "create root:root accounts for container $1 $2 port:$3"
    echo "create $2:$2 accounts for container $1 $2 port:$3"
}

CreateContainer $ImageName $ContainerName $Port

# ./createcontainer.sh dev_debian:11.6 stanley 9901