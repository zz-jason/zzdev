# Impala Development Environment

## What's in there

- the basic bash config
- the vim config
- the tmux config
- the basic environment for impala development

## How to build

```sh
docker build -t zzjason/impala-dev:ubuntu-20.04 .
```

## How to use

```sh
# Clone the impala source code
git clone https://github.com/apache/impala.git
export IMPALA_SRC=`pwd`/impala

# Pull the docker image for development
docker pull zzjason/impala-dev:ubuntu-20.04

# Start a container and mount the impala source to the docker
docker run --cap-add SYS_TIME -it \
           -p 25000:25000 -p 25010:25010 -p 25020:25020 \
           -v $IMPALA_SRC:/home/impdev/impala \
           --name impala-dev \
           zzjason/impala-dev:ubuntu-20.04 bash
```

**NOTE**: you can optionaly add pre-download impala toolchain to the docker
container as well:

```sh
docker run --cap-add SYS_TIME -it \
           -p 25000:25000 -p 25010:25010 -p 25020:25020 \
           -v $IMPALA_SRC:/home/impdev/impala \
           -v ${YOUR_IMPALA_TOOLCHAIN}:/opt/impala-toolchain
           --name impala-dev \
           zzjason/impala-dev:ubuntu-20.04 bash
```

After the docker container is started, you can login to the docker and build:

```sh
$IMPALA_HOME/bin/bootstrap_system.sh
source $IMPALA_HOME/bin/impala-config.sh
$IMPALA_HOME/buildall.sh -noclean -notests
$IMPALA_HOME/bin/create-test-configuration.sh -create_metastore -create_ranger_policy_db
$IMPALA_HOME/testdata/bin/run-all.sh
$IMPALA_HOME/bin/start-impala-cluster.py
```
