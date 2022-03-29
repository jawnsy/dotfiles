#!/bin/sh

set -o errexit
set -o nounset

make_directory() {
    target=$1
    mode=${2:-0755}

    if [ -d "$target" ]; then
        return
    fi

    OS=$(uname -s)
    echo "OS: $OS"
    if [ "$OS" = "Msys" ]; then
        # mkdir on Windows fails with --mode
        mkdir --verbose "$target"
    elif [ "$OS" = "Darwin" ]; then
        # Use Unix-style flags if we're running on macOS
        mkdir -v -m "$mode" "$target"
    else
        mkdir --verbose --mode="$mode" "$target"
    fi
}
