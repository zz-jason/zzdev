FROM ubuntu:20.04

RUN ln -snf /usr/share/zoneinfo/'Asia/Shanghai' /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone
RUN sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list
RUN sed -i s@/security.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list

# install prerequisted libriaries
RUN apt-get update && apt-get install -y \
        sudo apt-utils psmisc curl wget git ssh lsof gawk vim vim-common tmux \
        libffi-dev \
        libsasl2-dev libsasl2-modules libsasl2-modules-gssapi-mit libssl-dev \
        postgresql \
        python-dev python-setuptools \
        openjdk-8-jdk openjdk-8-source openjdk-8-dbg ant\
        g++ gcc ccache make ninja-build \
        fzf ctags \
        silversearcher-ag htop \
 && rm -rf /var/lib/apt/lists/*

# create user
RUN adduser --disabled-password --gecos '' impdev \
 && echo 'impdev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
 && mkdir -p /home/impdev/.m2 \
 && mkdir -p /home/impdev/.pip \
 && update-java-alternatives -s java-1.8.0-openjdk-amd64

# install maven
RUN wget -nv https://archive.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz \
 && tar -C /usr/local -x --no-same-owner -zf apache-maven-3.5.4-bin.tar.gz \
 && ln -sf /usr/local/apache-maven-3.5.4/bin/mvn /usr/local/bin \
 && rm -rf apache-maven-3.5.4-bin.tar.gz

COPY settings.xml /home/impdev/.m2/settings.xml
COPY pip.conf     /home/impdev/.pip/pip.conf
COPY tmux.conf    /home/impdev/.tmux.conf
COPY vimrc        /home/impdev/.vimrc
COPY bash_aliases /home/impdev/.bash_aliases

RUN chown -R impdev:impdev /home/impdev

USER impdev
WORKDIR /home/impdev
CMD ["bash"]
