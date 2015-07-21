# Editor
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR

# Path
BREW_PREFIX=$(brew --prefix)
XCODE_PATH="`xcode-select -print-path`/usr/bin:`xcode-select -print-path`/Toolchains/XcodeDefault.xctoolchain/usr/bin"
POSTGRESQL93='/Library/PostgreSQL/9.3'

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$XCODE_PATH:$POSTGRESQL93/bin:$HOME/bin:."

# Colors
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto'

# More Colors
if [ -s $BREW_PREFIX/etc/grc.bashrc ]
then
    . "`brew --prefix`/etc/grc.bashrc"
fi

# Prompt
if [ -s /usr/local/bin/mybash-prompt ]
then
    . /usr/local/bin/mybash-prompt
    mybash-prompt-reset newline-color bright-cyan \
                        delimeter-color bright-cyan \
                        text-color bright-white
fi

# Bash completion
if [ -s $BREW_PREFIX/etc/bash_completion ]
then
    . $BREW_PREFIX/etc/bash_completion
fi

# Virtualenv
if [ -s "/usr/local/bin/virtualenvwrapper.sh" ]
then
  . /usr/local/bin/virtualenvwrapper.sh
fi

# AWS
if [ -s /usr/local/bin/aws_completer ]
then
    complete -C /usr/local/bin/aws_completer aws
fi

# Ruby Version Manager
RVM_HOME=~/.rvm

if [ -s $RVM_HOME/scripts/rvm ]
then
    . $RVM_HOME/scripts/rvm
fi

# Node Version Manager
NVM_HOME=~/.nvm
NVM_ENV_HOME=$(brew --prefix nvm)

if [ -s $NVM_ENV_HOME/nvm.sh ]
then
  . $NVM_ENV_HOME/nvm.sh
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
alias ls="ls -Gh"
alias cls="clear && printf '\e[3J'"
alias vi=vim
