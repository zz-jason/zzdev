# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export GREP_COLOR='1;33'
export TERM="xterm-256color"

# alias
alias ssh='ssh -o ServerAliveInterval=30'
alias zj='tmux -L jianzhang attach -t jianzhang'
alias vi='vim'
alias fvi='vim $(fzf --height 40%)'
alias ll='ls -l'
alias grep='grep --color -n'

# java
export JAVA_HOME=/usr/local/jdk-19
export M2_HOME=/usr/local/apache-maven-3.8.6
export PATH=$M2_HOME/bin:$JAVA_HOME/bin:$PATH
