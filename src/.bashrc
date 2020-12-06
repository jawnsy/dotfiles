#!/usr/bin/env bash

# Initialization script for interactive bash shells.

# Source files relative to current script directory, so that changes can
# be tested using "source .bashrc" from anywhere
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -d "$DIR/.bashrc.d" ]; then
  for i in $DIR/.bashrc.d/*.sh; do
    if [ -r $i ]; then
      source $i
    else
      echo "File '$i' is not readable; skipping"
    fi
  done
  unset i
fi
