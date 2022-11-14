FROM ubuntu:22.04

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
# install cmake & gcc related tools
################################################################################
RUN apt-get update && apt-get install -y \
        cmake g++ gcc ccache make pkg-config bison flex gdb ninja-build \
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


################################################################################
# create user
################################################################################
RUN adduser --disabled-password --gecos '' --shell /usr/bin/zsh --force-badname jian.z \
 && echo 'jian.z ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /home/jian.z/.m2 \
 && mkdir -p /home/jian.z/.pip

COPY settings.xml /home/jian.z/.m2/settings.xml
COPY pip.conf     /home/jian.z/.pip/pip.conf
COPY zshrc        /home/jian.z/.zshrc
COPY tmux.conf    /home/jian.z/.tmux.conf
COPY vimrc        /home/jian.z/.vimrc


################################################################################
# Other settings
################################################################################
RUN chown -R jian.z:jian.z /home/jian.z

USER jian.z
WORKDIR /home/jian.z
CMD ["/usr/bin/zsh"]
