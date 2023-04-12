#!/bin/bash

if [ $# -lt 3 ]; then
  echo "Usage: createcontainer.sh [image_name:tag_name] [container_name] [port] [host_port_range]"
  exit -1
fi

script_file="$0"
if [ -L $0 ]; then
  script_dir=$(dirname $(readlink $0))
else
  script_dir=$(dirname $0)
fi
tools_dir="$script_dir/../tools"
image="$1"
name="$2"
port=$3
host_port_range="$4"
port_range=""

if [ $host_port_range ]; then
  container_port_start=19900
  container_port_max=21

  host_port_array=(${host_port_range//"-"/" "})
  host_port_array_len=${#host_port_array[@]}
  if [ 2 -ne $host_port_array_len ]; then
    echo "Error: the range must be two numbers, host ${host_port_array[@]}"
    exit -1
  fi
  host_port_start=${host_port_array[0]}
  host_port_max=$(expr ${host_port_array[1]} - $host_port_start)
  if [ $host_port_max -gt $container_port_max ]; then
    echo "Error: only supports opening up to 20 ports, host $host_port_range"
    exit -1
  fi
  port_range=""
  for i in $(seq 0 $host_port_max); do
    tmp_host_port=$(expr $host_port_start + $i)
    tmp_container_port=$(expr $container_port_start + $i)
    port_range="$port_range-p $tmp_host_port:$tmp_container_port "
  done
fi

function CreateContainer() {
  docker create --name "$2"_dvc -v /opt/docker_home hello-world:latest
  docker create --name "$2" --volumes-from "$2"_dvc -p "$3":22 $4 --security-opt seccomp=unconfined --privileged=true --restart=always "$1" /sbin/init
  docker start $2
  docker cp $script_dir/createuser.sh $2:/root
  docker cp $tools_dir $2:/opt/docker_home
  docker exec -it $2 /bin/bash /root/createuser.sh $2 $3
  echo "create root:root accounts for container $1 $2 port:$3"
  echo "create $2:$2 accounts for container $1 $2 port:$3"
}

CreateContainer $image $name $port "${port_range[@]}"

# ./createcontainer.sh gamemaster:1.0 stanley 9901 19900-19920
