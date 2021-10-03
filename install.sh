#!/bin/sh

set -o errexit
set -o nounset

echo "==> dotfile installation started"

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

SOURCE="$PROJECT_ROOT/src"

remove "$HOME/.bash_profile"

# Install symbolic links for home directory, so that changes are reflected
# in Git
echo
echo "--> Installing symbolic links to $HOME..."

link "$SOURCE/.bashrc" "$HOME/.bashrc"
make_directory "$HOME/.bashrc.d"
link "$SOURCE/.bashrc.d/aliases.sh" "$HOME/.bashrc.d/aliases.sh"
link "$SOURCE/.bashrc.d/completion.sh" "$HOME/.bashrc.d/completion.sh"
link "$SOURCE/.bashrc.d/history.sh" "$HOME/.bashrc.d/history.sh"
link "$SOURCE/.bashrc.d/path.sh" "$HOME/.bashrc.d/path.sh"
link "$SOURCE/.bashrc.d/prompt.sh" "$HOME/.bashrc.d/prompt.sh"
link "$SOURCE/.bashrc.d/terminal.sh" "$HOME/.bashrc.d/terminal.sh"

link "$SOURCE/.gitconfig" "$HOME/.gitconfig"

link "$SOURCE/.inputrc" "$HOME/.inputrc"

link "$SOURCE/.npmrc" "$HOME/.npmrc"
link "$SOURCE/.yarnrc" "$HOME/.yarnrc"

link "$SOURCE/.profile" "$HOME/.profile"

make_directory "$HOME/.ssh" 700
copy "$SOURCE/.ssh/config" "$HOME/.ssh/config"

echo
echo "==> dotfile installation completed successfully"
