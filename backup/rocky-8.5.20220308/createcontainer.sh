#!/bin/bash

if [ $# != 3 ]
then
    echo "Usage: createcontainer.sh [image_name] [container_name] [port]"
    exit 1
fi

ImageName="$1"
ContainerName="$2"
Port=$3

function CreateContainer(){
    docker create --name "$2"_dvc -v /opt/docker_home hello-world:latest
    docker create --name "$2" --volumes-from "$2"_dvc -p "$3":22  --security-opt seccomp=unconfined --privileged=true --restart=always "$1" /usr/sbin/init
    docker start $2
    docker exec -it $2 /bin/zsh
    echo "create root:root accounts for container $1 $2 port:$3"
}

CreateContainer $ImageName $ContainerName $Port

# ./createcontainer.sh dev_rocky:v8.5 dev01 9901