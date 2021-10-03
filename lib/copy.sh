#!/bin/sh

set -o errexit
set -o nounset

copy() {
    local source="$1"
    local target="$2"
    local mode=${3:-0644}

    # If the installed file is newer than the source one, do nothing
    if test "$target" -nt "$source"; then
        echo "--- Existing file $target is newer than source $source; skipping" >&2
        return
    fi

    install --verbose --compare --backup --mode="$mode" --no-target-directory "$source" "$target"
}
