#!/bin/sh

set -o errexit
set -o nounset

prompt() {
    question=$1
    answer=

    read -r -p "$question " answer
    case "$answer" in
        [Yy]*)
            return 0
            ;;
    esac

    return 1
}
