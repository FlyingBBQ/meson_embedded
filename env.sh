#!/bin/bash

CONTAINER="meson_env"

docker build config/ -t $CONTAINER
docker run -it -v $(pwd):/project -h build $CONTAINER bash 
