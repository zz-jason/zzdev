# zzdev: zz-jason's Development Environment

## What's in there

- language config for cpp/java
- the basic zsh config
- the vim config
- the tmux config

## How to get the image and start a container

Build the docker image:

```sh
IMAGE_NAME="zzjason/zzdev/ubuntu:20.04"
CONTAINER_NAME="zzdev-ubuntu-20.04"

# Build from souce
docker build -t $IMAGE_NAME .
```

Start a container with the above image:

```sh
# Start a container and mount the impala source to the docker
docker run -it -name ${CONTAINER_NAME} $IMAGE_NAME /usr/bin/zsh
```
