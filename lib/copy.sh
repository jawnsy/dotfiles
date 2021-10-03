#!/bin/sh

set -o errexit
set -o nounset

copy() {
    local source="$1"
    local name="$2"
    local mode=${3:-0644}

    # If the installed file is newer than the source one, do nothing
    if [ -n "$(find -L "$HOME/$name" -prune -newer "$source/$name")" ]; then
        echo "--- Existing file $HOME/$name is newer than source $source/$name; skipping" >&2
        return
    fi

    install --verbose --compare --backup --mode="$mode" --no-target-directory "$source/$name" "$HOME/$name"
}
