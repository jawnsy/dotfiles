#!/bin/sh

set -o errexit
set -o nounset

link() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        # If the symbolic link is already installed and points to the correct
        # location, do nothing
        local destination
        destination=$(readlink "$source")
        if [ "$destination" = "$source" ]; then
            return
        fi
    fi

    ln --symbolic --verbose --backup "$source" "$target"
}
