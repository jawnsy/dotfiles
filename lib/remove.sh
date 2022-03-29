#!/bin/sh

set -o errexit
set -o nounset

remove() {
    target="$1"

    if [ ! -e "$target" ]; then
        return
    fi

    OS=$(uname -s)
    if [ "$OS" = "Darwin" ]; then
        # Use Unix-style flags if we're running on macOS
        rm -v "$target"
    else
        rm --verbose "$target"
    fi
}
