#!/bin/bash

if [ $# != 1 ]
then
    echo "Usage: build.sh [image_name:tag_name]"
    exit 1
fi

docker login
docker pull centos:centos7.9.2009
docker build --network=host --no-cache -f Dockerfile -t $1 .