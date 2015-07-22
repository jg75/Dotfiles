# .bashrc

# Source global definitions
if [ -s /etc/bashrc ]
then
    . /etc/bashrc
fi

# User specific environment and startup programs
export PATH=$PATH:$HOME/bin

# Editor
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR

# VirtualEnv
export WORKON_HOME=$HOME/.virtualenvs

if [ -s /usr/bin/virtualenvwrapper.sh ]
then
    . /usr/bin/virtualenvwrapper.sh
fi

# Amber
export AMBER_CONFIG='config.StagingConfig'

# Colors
export LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export GREP_OPTIONS='--color=auto'

# Prompt
if [ -s /usr/local/bin/mybash-prompt ]
then
    . /usr/local/bin/mybash-prompt
    mybash-prompt-reset newline-color bright-yellow \
                        delimeter-color bright-yellow \
                        text-color bright-white \
                        hostname $NICKNAME
fi

# NVM
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
