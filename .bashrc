# .bashrc

# Source global definitions
if [ -s /etc/bashrc ]
then
    . /etc/bashrc
fi

# GoLang
export GOROOT=/usr/lib/golang
export GOPATH=$HOME/go

# Path
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$HOME/bin

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

# Settings
set -o vi

# Aliases
alias ls="ls --color"
alias cls="clear && printf '\e[3J'"
alias vi=vim
