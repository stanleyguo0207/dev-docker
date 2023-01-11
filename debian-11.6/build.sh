#!/bin/bash

if [ $# != 1 ]
then
    echo "Usage: build.sh [image_name:tag_name]"
    exit 1
fi

docker login
docker pull hello-world:latest
docker pull debian:11.6
docker build --network=host --no-cache -f Dockerfile -t $1 .

# ./build.sh dev_debian:v11.6
# docker run -it dev_debian:v11.6 /bin/bash