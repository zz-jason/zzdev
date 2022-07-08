# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export GREP_COLOR='1;33'
export PS1='\n[\e[0;36m\u@\h\e[m:\e[0;34m\W\e[m]\n\e[0;32m\$\e[m '

# alias
alias ssh='ssh -o ServerAliveInterval=30'
alias zj='tmux -L jianzhang attach -t jianzhang'
alias vi='vim'
alias ll='ls -l'
alias grep='grep --color -n'

# java
export JAVA_HOME=$(compgen -G '/usr/lib/jvm/java-8-openjdk-*')

# impala
export IMPALA_HOME=/home/impdev/impala
export IMPALA_TOOLCHAIN=/home/impdev/impala-toolchain
export PYPI_MIRROR=https://pypi.tuna.tsinghua.edu.cn

# cmake
export CMAKE_HOME=$IMPALA_TOOLCHAIN/toolchain-packages-gcc7.5.0/cmake-3.22.2
export PATH=$CMAKE_HOME/bin:$PATH
