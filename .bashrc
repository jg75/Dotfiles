# .bashrc

# Source global definitions
if [ -s /etc/bashrc ]
then
    . /etc/bashrc
fi

# Path
export PATH=$PATH:$HOME/bin

# Editor
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR

# Prompt
if [ -s /usr/local/bin/mybash-prompt ]
then
    . /usr/local/bin/mybash-prompt

    mybash-prompt-reset newline-color ${NEWLINE_COLOR:=bright-green} \
                        delimeter-color ${DELIMETER_COLOR:=bright-green} \
                        text-color ${TEXT_COLOR:=bright-white} \
                        hostname-variable NICKNAME
fi

# VirtualEnv
export WORKON_HOME=$HOME/.virtualenvs
VENV_WRAPPER=$(which virtualenvwrapper.sh)

if [ -s $VENV_WRAPPER ]
then
    . $VENV_WRAPPER
fi

# Colors
export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export GREP_OPTIONS='--color=auto'

# Bash Completion
if [ -s /etc/bash_completion ]
then
    . /etc/bash_completion
fi

# AWS Completion
AWS_COMPLETER=$(which aws_completer)

if [ -s $AWS_COMPLETER ]
then
    complete -C $AWS_COMPLETER aws
fi

# Ruby Version Manager
RVM_HOME=~/.rvm

if [ -s $RVM_HOME/scripts/rvm ]
then
    . $RVM_HOME/scripts/rvm
fi

# Node Version Manager
if [ -s $HOME/.nvm/nvm.sh ]
then
    . $HOME/.nvm/nvm.sh
fi

# Vim Man pages
vman() {
    vim -c "SuperMan $*"

    if [ $? -ne 0 ]
    then
        echo "No manual entry for $*"
    fi
}

docker-names() {
    # Docker name list of all running containers
    if [ $# -eq 0 ]
    then 
        docker ps | awk 'NR > 1 { print $NF }'
    else
        for APP in $@
        do
            docker ps | awk 'NR > 1 && $2 == app { print $NF }' app=$1
            shift
        done
    fi
}

docker-stop() {
    # Stop running containter(s)
    for NAME in $(docker-names $@)
    do
        docker stop $NAME
    done
}

docker-kill() {
    # Stop running container(s)
    # Delete docker image(s)
    docker-stop $@

    if [ $# -eq 0 ]
    then 
        docker images | awk 'NR > 1 { print $3 }' | xargs docker rmi -f
    else
        for APP in $@
        do
            docker images | awk 'NR > 1 && $1 == app { print $3 }' app=$1 | xargs docker rmi -f
            shift
        done
    fi
}

# Settings
set -o vi

# Aliases
alias ls="ls --color"
alias cls="clear && printf '\e[3J'"
alias vi=vim
