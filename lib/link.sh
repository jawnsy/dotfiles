#!/bin/sh

set -o errexit
set -o nounset

link() {
    source=$1
    target=$2

    if [ -L "$target" ]; then
        # Resolve the link and ensure it's pointing to the correct location
        destination=$(readlink "$target")
        if [ "$destination" = "$source" ]; then
            return 0
        fi
    fi

    OS=$(uname -s)
    if [ "$OS" = "Darwin" ]; then
        # Use Unix-style flags if we're running on macOS
        ln -sv "$source" "$target"
    else
        ln --symbolic --verbose --backup "$source" "$target"
    fi
}
