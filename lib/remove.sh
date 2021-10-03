#!/bin/sh

set -o errexit
set -o nounset

remove() {
    target="$1"

    if [ ! -e "$target" ]; then
        return
    fi

    rm --verbose "$target"
}
