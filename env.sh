#!/bin/bash

CONTAINER="meson_env"

# check if the container exists
#if [[ $(docker ps --filter "name=^/$name$" --format '{{.Names}}') == "$CONTAINER" ]]; then
#    # run the container
#    docker run -it -v $(pwd):/project -h build $CONTAINER bash
#else 
#    # build the container
#    docker build config/ -t $CONTAINER
#    # run the container
#    docker run -it -v $(pwd):/project -h build $CONTAINER bash
#fi

#docker image inspect $CONTAINER:latest >/dev/null 2>&1 && docker run -it -v $(pwd):/project -h build $CONTAINER bash || docker build config/ -t $CONTAINER

docker build config/ -t $CONTAINER --build-arg user=$USER --build-arg userid=$UID
docker run -it -v $(pwd):/project -h build -e USER=$USER -e USERID=$UID $CONTAINER bash 
