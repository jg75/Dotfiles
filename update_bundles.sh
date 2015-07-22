#! /bin/bash

VIM_DIR=$HOME/.vim
BUNDLE_DIR=$VIM_DIR/bundle
CONFIG_FILE=$BUNDLE_DIR/.bundle.list


readConfig() {
    FILE=$1

    awk 'BEGIN{
        comment = "#"
        count = 0
    }

    function stripComments(line) {
       if (line ~ comment) {
           line = substr(line, 0, index(line, comment) -1)
       }
       
       return line
    }
    
    function trim(line) {
        gsub(/^( )+/, "", line)
        gsub(/( )+$/, "", line)

        return line
    }

    {
        line = trim(stripComments($0))

        if (line ~ /^$/) {
            next
        }

        count += 1
        nf = split(line, fields, ",")
        name = fields[1]
        repository = fields[2]

        printf("BUNDLE_NAME[%s]=%s;\n", count, name)
        printf("BUNDLE_REPO[%s]=%s;\n", count, repository)

    }END{

    }' $FILE
}

updateBundles() {
    eval $(readConfig $CONFIG_FILE)

    echo "Updating bundles"

    while [ ${COUNT:=1} -le ${#BUNDLE_NAME[*]} ]
    do
        BUNDLE=$BUNDLE_DIR/${BUNDLE_NAME[$COUNT]}
        echo ${BUNDLE_NAME[$COUNT]}

        if [ -d $BUNDLE ]
        then
            cd $BUNDLE
            ISREPO=$(git rev-parse --is-inside-work-tree 2> /dev/null)

            if [ ${ISREPO:=false} == 'true' ]
            then
                git fetch origin -p && git pull --ff-only
            fi
        else
            cd $BUNDLE_DIR
            git clone ${BUNDLE_REPO[$COUNT]}
        fi

        cd - > /dev/null

        ((COUNT+=1))
    done
}


updateBundles
