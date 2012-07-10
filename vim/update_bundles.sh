#! /usr/bin/env sh

for REPO in vim.symlink/bundle/*; do
    pushd $REPO
    git pull
    popd
    done

