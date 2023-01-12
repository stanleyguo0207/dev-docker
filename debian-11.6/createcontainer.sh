#!/bin/bash

if [ $# != 4 ]
then
    echo "Usage: createcontainer.sh [image_name] [container_name] [port] [user]"
    exit 1
fi

ImageName="$1"
ContainerName="$2"
Port=$3
User="$4"

function CreateContainer(){
    docker create --name "$2"_dvc -v /opt/docker_home hello-world:latest
    docker create --name "$2" --volumes-from "$2"_dvc -p "$3":22  --security-opt seccomp=unconfined --privileged=true --restart=always "$1" /sbin/init
    docker start $2
    docker exec -it $2 /bin/bash /root/createuser.sh $4 $3
    echo "create root:root accounts for container $1 $2 port:$3"
    echo "create $4:$4 accounts for container $1 $2 port:$3"
}

CreateContainer $ImageName $ContainerName $Port $User

# ./createcontainer.sh dev_debian:v11.6 dev01 9901 user1