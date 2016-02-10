# Editor
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR

# Homebrew
BREW_PREFIX=$(brew --prefix)

# Path
XCODE_PATH="`xcode-select -print-path`/usr/bin:`xcode-select -print-path`/Toolchains/XcodeDefault.xctoolchain/usr/bin"
POSTGRESQL93='/Library/PostgreSQL/9.3'
NPM_BIN=$HOME/.npm/bin
RVM_BIN=$HOME/.rvm/bin

# GO
export GOROOT=$(brew --cellar go)/1.5.1/libexec
export GOPATH=$HOME/Work/go

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$XCODE_PATH:$POSTGRESQL93/bin:$NPM_BIN:$RVM_BIN:$GOROOT/bin:$GOPATH/bin:$HOME/bin:."

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
VENV_WRAPPER=$(which virtualenvwrapper.sh)

if [ -s $VENV_WRAPPER ]
then
  . $VENV_WRAPPER
fi

# AWS
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

docker-start() {
    # Start Docker Machine on Mac OS X
    DOCKER_SCRIPTS="/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts"

    if [ -x "$DOCKER_SCRIPTS/start.sh" ]
    then
        . "$DOCKER_SCRIPTS/start.sh"
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

docker-api() {
    docker-start
    docker-stop postgres mongo elasticsearch
    docker run -d -p 5432:5432 --net=host postgres
    docker run -d -p 27017:27017 --net=host mongo --smallfiles
    docker run -d -p 9200:9200 -p 9300:9300 elasticsearch --network.host _non_loopback_

    export PG_DOCKER=$(docker-names postgres)
    export PG_DB_USER=postgres
}

run-go-tests() {
    for dir in $(find $@ -type f -name "*_test.go" -exec dirname {} \; | sort -u)
    do
        cd $dir
        go test
        cd -
    done
}

go-test() {
    if [ $# -eq 0 ]
    then
        run-go-tests .
    else
        run-go-tests $@
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

# Settings
set -o vi

# Aliases
alias ls="ls -G"
alias cls="clear && printf '\e[3J'"
alias vi=vim
