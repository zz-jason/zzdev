FROM ubuntu:22.10

RUN ln -snf /usr/share/zoneinfo/'Asia/Shanghai' /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone
RUN sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list
RUN sed -i s@/security.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list

################################################################################
# install prerequisted libriaries
################################################################################
RUN apt-get update && apt-get install -y \
        sudo apt-utils curl wget git psmisc libffi-dev libncurses5-dev \
        libncursesw5-dev libevent-dev libsasl2-dev libsasl2-modules \
        libsasl2-modules-gssapi-mit libssl-dev libudev-dev \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
        build-essential manpages-dev software-properties-common \
        cmake g++ gcc ccache make pkg-config bison flex gdb ninja-build \
 && rm -rf /var/lib/apt/lists/*


################################################################################
# install tools to improve efficiency
################################################################################
RUN apt-get update && apt-get install -y \
    zsh tmux htop ssh lsof gawk \
    vim vim-common fzf universal-ctags silversearcher-ag \
 && rm -rf /var/lib/apt/lists/*


################################################################################
# install python related tools
################################################################################
RUN apt-get update && apt-get install -y \
        python-setuptools \
 && rm -rf /var/lib/apt/lists/*


################################################################################
# install java related tools
################################################################################
RUN wget -nv https://download.java.net/java/GA/jdk19/877d6127e982470ba2a7faa31cc93d04/36/GPL/openjdk-19_linux-x64_bin.tar.gz \
 && tar -C /usr/local -x --no-same-owner -zf openjdk-19_linux-x64_bin.tar.gz \
 && rm -rf openjdk-19_linux-x64_bin.tar.gz

RUN wget -nv https://archive.apache.org/dist/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz \
 && tar -C /usr/local -x --no-same-owner -zf apache-maven-3.8.6-bin.tar.gz \
 && rm -rf apache-maven-3.8.6-bin.tar.gz

RUN apt-get update \
 && apt-get install -y libaio-dev libtbb-dev \
 && rm -rf /var/lib/apt/lists/*

################################################################################
# install google related cpp tools
################################################################################
RUN apt-get update && apt-get install -y \
        libabsl-dev libgoogle-glog-dev \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.m2 \
 && mkdir -p /root/.pip

COPY settings.xml /root/.m2/settings.xml
COPY pip.conf     /root/.pip/pip.conf
COPY bashrc       /root/.bashrc
COPY tmux.conf    /root/.tmux.conf
COPY vimrc        /root/.vimrc


################################################################################
# Other settings
################################################################################

USER root
WORKDIR /root
CMD ["/usr/bin/bash"]
