#!/bin/sh

set -o errexit
set -o nounset

copy() {
    source=$1
    target=$2
    mode=${3:-0644}

    # If the installed file is newer than the source one, do nothing
    if test "$target" -nt "$source"; then
        echo "--- Existing file $target is newer than source $source; skipping" >&2
        return
    fi

    OS=$(uname -s)
    if [ "$OS" = "Darwin" ]; then
        # Use Unix-style flags if we're running on macOS
       install -vb -m "$mode" -p "$source" "$target"
    else
        install --verbose --compare --backup --mode="$mode" --no-target-directory "$source" "$target"
    fi
}
