#!/bin/sh

set -o errexit
set -o nounset

make_directory() {
    local name="$1"
    local mode=${2:-0755}

    if [ -d "$HOME"/"$name" ]; then
        return
    fi

    local OS
    OS=$(uname --operating-system)

    if [ "$OS" = "Msys" ]; then
        # mkdir on Windows fails with --mode
        mkdir --verbose "$HOME"/"$name"
    else
        mkdir --verbose --mode="$mode" "$HOME"/"$name"
    fi
}
