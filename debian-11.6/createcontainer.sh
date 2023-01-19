#!/bin/bash

if [ $# != 3 ]
then
    echo "Usage: createcontainer.sh [image_name:tag_name] [container_name] [port]"
    exit 1
fi

script_file="$0"
if [ -L $0 ]
then
    script_dir=`dirname $(readlink $0)`
else
    script_dir=`dirname $0`
fi
tools_dir="$script_dir/../tools"
image="$1"
name="$2"
port=$3

function CreateContainer(){
    docker create --name "$2"_dvc -v /opt/docker_home hello-world:latest
    docker create --name "$2" --volumes-from "$2"_dvc -p "$3":22  --security-opt seccomp=unconfined --privileged=true --restart=always "$1" /sbin/init
    docker start $2
    docker cp $script_dir/createuser.sh $2:/root
    docker cp $tools_dir $2:/opt/docker_home
    docker exec -it $2 /bin/bash /root/createuser.sh $2 $3
    echo "create root:root accounts for container $1 $2 port:$3"
    echo "create $2:$2 accounts for container $1 $2 port:$3"
}

CreateContainer $image $name $port

# ./createcontainer.sh dev_debian:11.6 stanley 9901