# Impala Development Environment

## What's in there

- the basic bash config
- the vim config
- the tmux config
- the basic environment for impala development

## How to get the image and start a container

Get the docker image:

```sh
# Build from souce
docker build -t zzjason/impala-dev:ubuntu-20.04 .

# Pull from Docker Hub
docker pull zzjason/impala-dev:ubuntu-20.04
```

Start the docker container with the above image:

```sh
# Start a container and mount the impala source to the docker
docker run --cap-add SYS_TIME -it \
           -p 25000:25000 -p 25010:25010 -p 25020:25020 \
           -v ${YOUR_IMPALA_SOURCE_CODE}:/home/impdev/impala \
           -v ${YOUR_IMPALA_TOOLCHAIN}:/home/impdev/impala-toolchain \
           --name impala-dev \
           zzjason/impala-dev:ubuntu-20.04 bash
```

## Develop impala in the container

After the docker container is started, you can login to the docker and build:

```sh
$IMPALA_HOME/bin/bootstrap_system.sh
source $IMPALA_HOME/bin/impala-config.sh
$IMPALA_HOME/buildall.sh -noclean -notests
$IMPALA_HOME/bin/create-test-configuration.sh -create_metastore -create_ranger_policy_db
$IMPALA_HOME/testdata/bin/run-all.sh
$IMPALA_HOME/bin/start-impala-cluster.py
```

After making changings to the impala source code, you may need to build it and start the impala cluster to verify your modifications:

```sh
$IMPALA_HOME/buildall.sh -noclean -notests
$IMPALA_HOME/bin/start-impala-cluster.py --kill
$IMPALA_HOME/bin/start-impala-cluster.py
```
