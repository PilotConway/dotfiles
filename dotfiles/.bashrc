# .bashrc
# John L Conway IV

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Turn on Git completion
GITCOMPLETION=/etc/bash_completion.d/git
if [[ -f $GITCOMPLETION ]] ; then 
    source $GITCOMPLETION
fi 

## 
# Aliases
## 
alias ls="ls --color=auto"
alias fps="ps -eo pid,user,command | grep"
alias tmuxa="tmux -2 a || tmux -2 || /bin/bash"

## 
# Exports
## 
export JAVA_HOME=/usr/java/latest
export GMOCK_HOME=/home/jlconw2/software/gmock-1.6.0

## 
# Functions
## 
function ssht() 
{ 
    ssh -Y $* -t "tmux -2 a || tmux -2 || /bin/bash"
} 

