#!/bin/sh

set -o errexit
set -o nounset

echo "==> dotfile installation started"

SOURCE=$PWD/src

OS=$(uname --operating-system)

link() {
    name="$1"

    if [ -L "$HOME"/"$name" ]; then
        # If the symbolic link is already installed and points to the correct
        # location, do nothing
        target=$(readlink "$HOME"/"$name")
        if [ "$target" = "$SOURCE"/"$name" ]; then
            return
        fi
    fi

    ln --symbolic --verbose --backup "$SOURCE"/"$name" "$HOME"/"$name"
}

make_directory() {
    name="$1"
    mode=${2:-0755}

    if [ -d "$HOME"/"$name" ]; then
        return
    fi

    if [ "$OS" = "Msys" ]; then
        # mkdir on Windows fails with --mode
        mkdir --verbose "$HOME"/"$name"
    else
        mkdir --verbose --mode="$mode" "$HOME"/"$name"
    fi
}

copy() {
    name="$1"
    mode=${2:-0644}

    # If the installed file is newer than the source one, do nothing
    if [ -n "$(find -L "$HOME"/"$name" -prune -newer "$SOURCE"/"$name")" ]; then
        echo "--- Existing file $HOME/$name is newer than source $SOURCE/$name; skipping" >&2
        return
    fi

    install --verbose --compare --backup --mode="$mode" --no-target-directory "$SOURCE"/"$name" "$HOME"/"$name"
}

remove() {
    name="$1"

    if [ ! -e "$HOME"/"$name" ]; then
        return
    fi

    rm --verbose "$HOME"/"$name"
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
link .bashrc.d/aliases.sh
link .bashrc.d/completion.sh
link .bashrc.d/history.sh
link .bashrc.d/path.sh
link .bashrc.d/prompt.sh
link .bashrc.d/terminal.sh

link .gitconfig

link .inputrc

link .npmrc

link .profile

make_directory .ssh 700
copy .ssh/config

echo
echo "==> dotfile installation completed successfully"
