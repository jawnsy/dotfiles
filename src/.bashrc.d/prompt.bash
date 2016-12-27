#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

reset='\[\e[m\]'
normal_green='\[\e[0;32m\]'
normal_yellow='\[\e[0;33m\]'
normal_purple='\[\e[0;35m\]'
normal_cyan='\[\e[0;36m\]'
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


export PROMPT_COMMAND='echo -ne "\033]0;${USER}@$(hostname -s): ${PWD}\007"'

