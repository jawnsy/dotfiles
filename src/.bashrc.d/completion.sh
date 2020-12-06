#!/usr/bin/env bash

# Return exit status of failed command in pipeline
set -o pipefail

# Exit on unbound variables to ensure they are handled correctly.
# This is useful for diagnostics, but can't be left enabled
# because other scripts may rely on the default behavior.
#set -o nounset

# If not running interactively, don't do anything
if [ -z "${PS1:-}" ]; then
    return
fi

# enable bash completion in interactive shells
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        # Suppress linting for files provided by the operating system
        # shellcheck disable=SC1090,SC1091
        source /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        # Suppress linting for files provided by the operating system
        # shellcheck disable=SC1090,SC1091
        source /etc/bash_completion
    fi
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found ] || [ -x /usr/share/command-not-found/command-not-found ]; then
    function command_not_found_handle {
        # check because c-n-f could've been removed in the meantime
        if [ -x /usr/lib/command-not-found ]; then
            /usr/lib/command-not-found -- "$1"
            return $?
        elif [ -x /usr/share/command-not-found/command-not-found ]; then
            /usr/share/command-not-found/command-not-found -- "$1"
            return $?
        else
            printf "%s: command not found\n" "$1" >&2
            return 127
        fi
    }
fi
