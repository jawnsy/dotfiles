# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Check window size after each command and update LINES and COLUMNS
shopt -s checkwinsize

# Automatically fix minor typos in "cd" directory names
shopt -s cdspell

# Include subdirectories when expanding "**" pattern
shopt -s globstar

# Do not search PATH when using "source" builtin
shopt -u sourcepath

# Notify when background jobs terminate
set -o notify

# Return exit status of failed command in pipeline
set -o pipefail

# Don't use ^D to exit
set -o ignoreeof
