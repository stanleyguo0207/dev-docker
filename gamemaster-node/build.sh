#!/bin/bash

if [ $# != 1 ]; then
  echo "Usage: build.sh [image_name:tag_name]"
  exit 1
fi

docker login
docker pull hello-world:latest
docker pull node:18.15-bullseye
docker build --network=host --no-cache -f Dockerfile -t $1 .

# ./build.sh gamemaster-node:1.0
# docker run -it gamemaster-node:1.0 /bin/bash
