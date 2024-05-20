#!/usr/bin/env bash

# get script directory as absolute path
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# get repository directory as absolute path
REPOSITORY_DIR="$( cd "$( dirname "${SCRIPT_DIR}" )" &> /dev/null && pwd )/colcon_ws"

docker run \
--rm \
--tty \
--interactive \
--privileged \
--publish 50000-50004:50000-50004 \
--publish 54321:54321 \
--env DISPLAY=$DISPLAY \
--volume /tmp/.X11-unix:/tmp/.X11-unix \
--volume ${REPOSITORY_DIR}:/root/colcon_ws \
--name rvl-ur-robotiq-container \
mqt0029/ur-robotiq:latest \
bash