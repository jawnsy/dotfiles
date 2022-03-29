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

reset='\[\e[m\]'
normal_green='\[\e[0;32m\]'
normal_yellow='\[\e[0;33m\]'
normal_purple='\[\e[0;35m\]'
bright_gray='\[\e[1;30m\]'
bright_red='\[\e[1;31m\]'
bright_yellow='\[\e[1;33m\]'
bright_white='\[\e[1;37m\]'

PS1="${bright_white}\A "
if [ ${EUID} -eq 0 ]; then
  PS1+="${bright_red}\h ${normal_green}\w ${bright_yellow}# ${reset}"
else
  PS1+="${normal_purple}\u${bright_gray}@${normal_green}\h ${normal_yellow}\w ${reset}\$ "
fi
export PS1
export PS2="${bright_white}> ${reset}"
export PS3="${bright_white}? ${reset}"
export PS4="${bright_white}+ ${reset}"

if [ "$OS" = "Msys" ]; then
    export PROMPT_COMMAND='echo -ne "\e]0;${USERNAME}@${HOSTNAME}: $(dirs +0)\a"'
else
    export PROMPT_COMMAND='echo -ne "\e]0;${USER}@${HOSTNAME}: $(dirs +0)\a"'
fi
