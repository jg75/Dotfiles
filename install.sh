#! /bin/bash

[ ! -x $BASH ] && exit

UNAME=$(uname -s)
PNAME=$(basename $0)
DIRNAME=$(dirname $0)

if [ $UNAME = 'Darwin' ]
then
    BASH_PROFILE=.bash_profile
elif [ $UNAME = 'Linux' ]
then
    BASH_PROFILE=.bashrc
else
    exit
fi

if [ $UNAME = 'Linux' ] && [ -d /var/lib/cloud/scripts ]
then
    for DIR in $(find /var/lib/cloud/scripts -mindepth 1  -maxdepth 1 -type d)
    do
        SOURCE_DIR=$DIRNAME/var/lib/cloud/scripts/$(basename $DIR)

        if [ -d $SOURCE_DIR ]
        then
            for FILE in $(find $SOURCE_DIR -type f)
            do
                sudo cp $FILE $DIR
            done
        fi
    done
fi

if [ $(ls -dl /usr/local/bin | awk '{ print $3 }') != $(whoami) ]
then
    sudo cp $DIRNAME/usr/local/bin/* /usr/local/bin
else
    cp $DIRNAME/usr/local/bin/* /usr/local/bin
fi

cp $DIRNAME/$BASH_PROFILE $HOME
sudo cp $DIRNAME/$BASH_PROFILE.root ~root/$BASH_PROFILE

for FILE in $(find $DIRNAME -type f \
                   -mindepth 1 -maxdepth 1 \
                   \( ! -name "$PNAME" \
                   -a ! -name "README.md" \
                   -a ! -name ".bash_profile*" \
                   -a ! -name ".bashrc*" \))
do
    cp $FILE $HOME
    sudo cp $FILE ~root
done

for DIR in $(find $DIRNAME -type d \
                  -mindepth 1 -maxdepth 1 \
                  \( ! -name "usr" \
                  -a ! -name "var" \
                  -a ! -name ".git" \))
do
    mkdir -p $HOME/$(basename $DIR)
    cp -r $DIR $HOME
done

$HOME/bin/update_bundles.sh