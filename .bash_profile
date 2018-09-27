# Path
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin

# Editor
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR

# History
export HISTSIZE=5000

# Homebrew
export BREW_PREFIX=$(brew --prefix)

if [ -s $HOME/.github ]
then
    export HOMEBREW_GITHUB_API_TOKEN=$(<$HOME/.github)
fi

export PGDATA=$BREW_PREFIX/var/postgres
export PGLOG=$PGDATA/pg_log

# Xcode
XCODE_PATH="$(xcode-select -print-path)/usr/bin:$(xcode-select -print-path)/Toolchains/XcodeDefault.xctoolchain/usr/bin"

export GOROOT=$(brew --cellar go)/1.8.3/libexec
export GOPATH=$HOME/Work/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin


if [ -s /usr/local/bin/virtualenvwrapper.sh ]
then
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    export WORKON_HOME=~/.virtualenvs

    . /usr/local/bin/virtualenvwrapper.sh
fi

#if [ -s $BREW_PREFIX/etc/docker-completion ]
#then
#    . $BREW_PREFIX/etc/docker-completion
#fi

# Node
if [ -s $(brew --prefix nvm)/nvm.sh ]
then
    export NVM_DIR=$HOME/.nvm
    export NPM_DIR=$HOME/.npm

    . $(brew --prefix nvm)/nvm.sh

    export PATH=$PATH:$NVM_BIN
fi


# Bash completion
if [ -s $BREW_PREFIX/etc/bash_completion ]
then
    . $BREW_PREFIX/etc/bash_completion
fi

# AWSCLI completions
AWS_COMPLETER=/usr/local/bin/aws_completer

if [ -x $AWS_COMPLETER ]
then
    complete -C $AWS_COMPLETER aws
fi

# Colors
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
export GREP_OPTIONS='--color=auto'

# More Colors
if [ -s $BREW_PREFIX/etc/grc.bashrc ]
then
    . $BREW_PREFIX/etc/grc.bashrc
fi

if [ -s $HOME/.fabrc.bash ]
then
    . ~/.fabrc.bash
fi

# Prompt
if [ -x /usr/local/bin/mybash-prompt ]
then
    . /usr/local/bin/mybash-prompt
    mybash-prompt-reset newline-color bright-cyan \
                        delimeter-color bright-cyan \
                        text-color bright-white
fi

export PATH=$PATH:.

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

git-rename-tag() {
    old=$1
    new=$(awk -v tag=$old 'BEGIN{printf("v0.%s\n", substr(tag, 2))}')

    if [ "$(git tag -l $new)" == "$new" ]
    then
        echo $new already exists
    else
        git tag $new $old
        git tag -d $old
        git push origin :refs/tags/$old
        git push --tags
    fi
}

git-branch-poopy() {
    git rev-parse --abbrev-ref HEAD | grep -v HEAD ||
        git describe --exact-match HEAD 2> /dev/null ||
        git rev-parse HEAD
}

git-checked-out() {
    git reflog HEAD | awk '/checkout:/{print $NF; exit}'
}


# Settings
set -o vi

# Aliases
if [ $(whoami) == 'root' ]
then
    alias vim='/usr/bin/vim'
fi

alias ls="ls -G"
alias vi=vim
alias cat='ccat --bg=dark'
