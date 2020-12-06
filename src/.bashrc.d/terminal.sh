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

# Check window size after each command and update LINES and COLUMNS
shopt -s checkwinsize

# Automatically fix minor typos in "cd" directory names
shopt -s cdspell

# Include subdirectories when expanding "**" pattern
shopt -s globstar

# Require explicit filenames when using "source" builtin; do not search PATH
shopt -u sourcepath

# Notify when background jobs terminate
set -o notify

# Don't use ^D to exit
set -o ignoreeof
