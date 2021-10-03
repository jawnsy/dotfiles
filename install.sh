#!/bin/sh

set -o errexit
set -o nounset

echo "==> dotfile installation started"

SOURCE=$PWD/src

PROJECT_ROOT=$(git rev-parse --show-toplevel)
# shellcheck source=lib/copy.sh
. "$PROJECT_ROOT/lib/copy.sh"
# shellcheck source=lib/make_directory.sh
. "$PROJECT_ROOT/lib/make_directory.sh"
# shellcheck source=lib/link.sh
. "$PROJECT_ROOT/lib/link.sh"
# shellcheck source=lib/remove.sh
. "$PROJECT_ROOT/lib/remove.sh"

# Remove unnecessary/redundant files
echo
echo "--> Removing redundant/unnecessary files..."

remove .bash_profile

# Install symbolic links for home directory, so that changes are reflected
# in Git
echo
echo "--> Installing symbolic links to $HOME..."

link "$SOURCE" .bashrc
make_directory .bashrc.d
link "$SOURCE" .bashrc.d/aliases.sh
link "$SOURCE" .bashrc.d/completion.sh
link "$SOURCE" .bashrc.d/history.sh
link "$SOURCE" .bashrc.d/path.sh
link "$SOURCE" .bashrc.d/prompt.sh
link "$SOURCE" .bashrc.d/terminal.sh

link "$SOURCE" .gitconfig

link "$SOURCE" .inputrc

link "$SOURCE" .npmrc
link "$SOURCE" .yarnrc

link "$SOURCE" .profile

make_directory .ssh 700
copy "$SOURCE" .ssh/config

echo
echo "==> dotfile installation completed successfully"
