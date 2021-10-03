#!/bin/sh

set -o errexit
set -o nounset

link() {
    local source="$1"
    local name="$2"

    if [ -L "$HOME/$name" ]; then
        # If the symbolic link is already installed and points to the correct
        # location, do nothing
        target=$(readlink "$HOME/$name")
        if [ "$target" = "$source/$name" ]; then
            return
        fi
    fi

    ln --symbolic --verbose --backup "$source/$name" "$HOME/$name"
}
