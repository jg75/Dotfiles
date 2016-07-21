# Editor
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR

# Homebrew
export BREW_PREFIX=$(brew --prefix)

if [ -s $HOME/.github ]
then
    export HOMEBREW_GITHUB_API_TOKEN=$(<$HOME/.github)
fi

# Path
export PGDATA="$HOME/Library/Application Support/Postgres/var-9.5"
XCODE_PATH="`xcode-select -print-path`/usr/bin:`xcode-select -print-path`/Toolchains/XcodeDefault.xctoolchain/usr/bin"
POSTGRESQL='/Applications/Postgres.app/Contents/Versions/9.5'
NPM_BIN=$HOME/.npm/bin
RVM_BIN=$HOME/.rvm/bin

# GO
export GOROOT=$(brew --cellar go)/1.6.2/libexec
export GOPATH=$HOME/Work/go

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$XCODE_PATH:$POSTGRESQL/bin:$NPM_BIN:$RVM_BIN:$GOROOT/bin:$GOPATH/bin:$HOME/bin:."

# Colors
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto'

# More Colors
if [ -s $BREW_PREFIX/etc/grc.bashrc ]
then
    . $BREW_PREFIX/etc/grc.bashrc
fi

# Prompt
if [ -x /usr/local/bin/mybash-prompt ]
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
VENV_WRAPPER=/usr/local/bin/virtualenvwrapper.sh

if [ -x $VENV_WRAPPER ]
then
    . $VENV_WRAPPER
fi

# AWS
AWS_COMPLETER=/usr/local/bin/aws_completer

if [ -x $AWS_COMPLETER ]
then
    complete -C $AWS_COMPLETER aws
fi

# Node Version Manager
#export NVM_DIR=$HOME/.nvm

#if [ -s $(brew --prefix nvm)/nvm.sh ]
#then
#    . $(brew --prefix nvm)/nvm.sh
#fi

# Vim Man pages
vman() {
    vim -c "SuperMan $*"

    if [ $? -ne 0 ]
    then
        echo "No manual entry for $*"
    fi
}

git-stale-local() {
    awk 'BEGIN{
        cmd = "git ls-remote -h origin"
        FS = "/"

        while (cmd | getline) {
            exclude[$NF] =  1
        }

        cmd = "git branch --merged"
        FS = " "

        while (cmd | getline) {
            branch = $NF

            if (!(branch in exclude)) {
                print branch
            }
        }
    }'
}

git-cleanup() {
    git fetch origin -p
    git remote prune origin

    for branch in $(git-stale-local)
    do
        git branch -d $branch
    done
}

if [ -s $HOME/.fabrc.bash ]
then
    . ~/.fabrc.bash
fi

# Settings
set -o vi

if [ $(whoami) == 'root' ]
then
    alias vim='/usr/bin/vim'
fi

# Aliases
alias ls="ls -G"
alias vi=vim
