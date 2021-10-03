#!/bin/sh

set -o errexit
set -o nounset

remove() {
    name="$1"

    if [ ! -e "$HOME/$name" ]; then
        return
    fi

    rm --verbose "$HOME/$name"
}
