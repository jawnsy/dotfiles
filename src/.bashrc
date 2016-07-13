#!/bin/bash

# Initialization script for interactive bash shells.
if [ -d "$HOME/.bashrc.d" ]; then
  for i in $HOME/.bashrc.d/*.bash; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
