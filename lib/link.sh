#!/bin/sh

set -o errexit
set -o nounset

link() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        # Resolve the link and ensure it's pointing to the correct location
        local destination
        destination=$(readlink "$target")
        if [ "$destination" = "$source" ]; then
            return 0
        fi
    fi

    ln --symbolic --verbose --backup "$source" "$target"
}
