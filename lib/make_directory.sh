#!/bin/sh

set -o errexit
set -o nounset

make_directory() {
    local target="$1"
    local mode=${2:-0755}

    if [ -d "$target" ]; then
        return
    fi

    local OS
    OS=$(uname --operating-system)

    if [ "$OS" = "Msys" ]; then
        # mkdir on Windows fails with --mode
        mkdir --verbose "$target"
    else
        mkdir --verbose --mode="$mode" "$target"
    fi
}
