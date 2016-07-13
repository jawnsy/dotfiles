#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

PS1="\[\e[1;37m\]\A "
if [ $EUID -eq 0 ]; then
  PS1="$PS1\[\e[1;31m\]\h \[\e[0;32m\]\w \[\e[1;33m\]# \[\e[0m\]"
else
  PS1="$PS1\[\e[0;35m\]\u\[\e[1;30m\]@\[\e[0;32m\]\h\[\e[1;30m\]:\[\e[1;33m\]\w\[\e[1;30m\]\[\e[1;37m\] $ \[\e[0m\]"
fi
export PS1

export PS2="\[\e[1;37m\]> \[\e[0m\]"
export PS3="\[\e[1;37m\]? \[\e[0m\]"
export PS4="\[\e[1;37m\]+ \[\e[0m\]"

export PROMPT_COMMAND='echo -ne "\033]0;${USER}@$(hostname -s): ${PWD}\007"'

