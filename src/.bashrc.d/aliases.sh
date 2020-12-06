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

# Confirm on deletion/move/copy and list actions performed
alias rm="rm -iv"
alias mv="mv -iv"
alias cp="cp -iv"
alias ln="ln -iv"

# Display notification of permission or ownership changes
alias chmod="chmod -v"
alias chown="chown -v"
alias chgrp="chgrp -v"

# Human readable mode
alias df="df -h"
alias du="du -ch"
alias free="free -h"
alias ls="ls -h --color=auto"
alias quota="quota --human-readable"
alias info="pinfo"

# Display summary for users(1) and verbose information for w(1)
alias who="who --login --users --heading"
alias users="who --users --count"
alias w="w -u"
