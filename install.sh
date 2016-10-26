#!/bin/sh

set -o errexit
set -o nounset

echo "==> dotfile installation started"

SOURCE=$PWD/src

link() {
  local name=$1

  if [ -L $HOME/$name ]; then
    # If the symbolic link is already installed and points to the correct
    # location, do nothing
    target=$(readlink $HOME/$name)
    if [ $target = $SOURCE/$name ]; then
      return
    fi
  fi

  ln --symbolic --verbose --backup $SOURCE/$name $HOME/$name
}

make_directory() {
  local name=$1
  local mode=${2:-0755}

  if [ -d $HOME/$name ]; then
    return
  fi

  mkdir --parents --verbose --mode=$mode $HOME/$name
}

copy() {
  local name=$1
  local mode=${2:-0644}

  # If the installed file is newer than the source one, do nothing
  if [ $HOME/$name -nt $SOURCE/$name ]; then
    echo "--- Existing file $HOME/$name is newer than source $SOURCE/$name; skipping" >&2
    return
  fi

  install --verbose --compare --backup --mode=$mode --no-target-directory $SOURCE/$name $HOME/$name
}

remove() {
  local name=$1

  if [ ! -e $HOME/$name ]; then
    return
  fi

  rm --verbose $HOME/$name
}

# Remove unnecessary/redundant files
echo
echo "--> Removing redundant/unnecessary files..."

remove .bash_profile

# Install symbolic links for home directory, so that changes are reflected
# in Git
echo
echo "--> Installing symbolic links to $HOME..."

link .bashrc
make_directory .bashrc.d
link .bashrc.d/aliases.bash
link .bashrc.d/completion.bash
link .bashrc.d/history.bash
link .bashrc.d/path.bash
link .bashrc.d/prompt.bash
link .bashrc.d/terminal.bash

link .gitconfig

link .inputrc

link .profile

make_directory .ssh 700
copy .ssh/config

echo
echo "==> dotfile installation completed successfully"
