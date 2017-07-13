# .bashrc

# Source global definitions
if [ -s /etc/bashrc ]
then
    . /etc/bashrc
fi

# Path
export PATH=$PATH:$HOME/bin:.

# Editor
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR

# Prompt
if [ -s /usr/local/bin/mybash-prompt ]
then
    . /usr/local/bin/mybash-prompt

    if [ $(id -u) -eq 0 ]
    then
        NEWLINE_COLOR=bright-red
        DELIMETER_COLOR=bright-red
    fi

    mybash-prompt-reset newline-color ${NEWLINE_COLOR:=yellow} \
                        delimeter-color ${DELIMETER_COLOR:=yellow} \
                        text-color ${TEXT_COLOR:=bright-white} \
                        hostname-variable NICKNAME
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
set -m

# Aliases
alias ls="ls --color"
alias vi=vim
