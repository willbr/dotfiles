#! /usr/bin/env sh

while read -r URL; do
    NAME=`basename $URL | sed -E 's/(\.vim)?\.git$//'`
    TARGET=vim.symlink/bundle/$NAME
    if [[ -d "$TARGET" ]]; then
        echo $NAME already exists: $TARGET
    else
        git clone $URL $TARGET
    fi
    done < bundle_urls.txt

