# Simple profile to ensure ~/.bashrc is read for login shells
if ! test -z $BASH_VERSION; then
  . ~/.bashrc
fi
