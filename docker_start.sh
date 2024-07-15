#!/usr/bin/env bash

# ensure docker
DOCKER_BIN=$(which docker)
if [ -z $DOCKER_BIN ]; then
  echo "docker not installed or not in \$PATH"
  exit 1
fi

# start existing
# NOT_RUNNING=1
CONTAINER_ID=$(docker ps -a | grep "sd-webui")
NOT_RUNNING=$?
if [ ! -z $CONTAINER_ID ]; then
  CONTAINER_ID=${CONTAINER_ID// *}
fi


docker build . -t ghcr.io/automatic1111/stable-diffusion-webui
