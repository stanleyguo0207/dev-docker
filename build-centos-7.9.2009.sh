#!/bin/bash

if [ $# != 1 ]
then
    echo "Usage: build-centos-7.9.2009.sh [image_name:tag_name]"
    exit 1
fi

docker login
docker pull centos:centos7.9.2009
docker build --network=host --no-cache -f centos-7.9.2009.dockerfile -t $1 .