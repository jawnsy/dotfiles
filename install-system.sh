#!/bin/sh

set -o errexit
set -o nounset

echo "==> system installation started"

PROJECT_ROOT=$(git rev-parse --show-toplevel)
# shellcheck source=lib/copy.sh
. "$PROJECT_ROOT/lib/copy.sh"
# shellcheck source=lib/make_directory.sh
. "$PROJECT_ROOT/lib/make_directory.sh"
# shellcheck source=lib/link.sh
. "$PROJECT_ROOT/lib/link.sh"
# shellcheck source=lib/prompt.sh
. "$PROJECT_ROOT/lib/prompt.sh"
# shellcheck source=lib/remove.sh
. "$PROJECT_ROOT/lib/remove.sh"

# Remove unnecessary/redundant files
echo
echo "--> Removing redundant/unnecessary files..."

FILES="$PROJECT_ROOT/files"

make_directory "/etc/apt/preferences.d"
make_directory "/etc/apt/sources.list.d"
make_directory "/etc/default"
make_directory "/usr/local/share/keyrings"

if prompt "Install Google Chrome repositories? (y/N)"; then
    copy "$FILES/etc/apt/preferences.d/google-chrome" "/etc/apt/preferences.d/google-chrome"
    copy "$FILES/etc/apt/sources.list.d/google-chrome.list" "/etc/apt/sources.list.d/google-chrome.list"

    # Install repository-specific keyring
    copy "$FILES/usr/local/share/keyrings/google-chrome.gpg" "/usr/local/share/keyrings/google-chrome.gpg"

    # Prevent Chrome from adding repositories and keys, since
    # we want to manage these ourselves.
    copy "$FILES/etc/default/google-chrome" "/etc/default/google-chrome"
else
    remove "/etc/apt/sources.list.d/google-chrome.list"
fi

if prompt "Install Microsoft Edge repositories? (y/N)"; then
    copy "$FILES/etc/apt/preferences.d/microsoft-edge" "/etc/apt/preferences.d/microsoft-edge"
    copy "$FILES/etc/apt/sources.list.d/microsoft-edge.list" "/etc/apt/sources.list.d/microsoft-edge.list"

    # Install repository-specific keyring
    copy "$FILES/usr/local/share/keyrings/microsoft.gpg" "/usr/local/share/keyrings/microsoft.gpg"

    # Prevent Edge from adding repositories and keys, since
    # we want to manage these ourselves.
    copy "$FILES/etc/default/microsoft-edge-beta" "/etc/default/microsoft-edge-beta"
    copy "$FILES/etc/default/microsoft-edge-dev" "/etc/default/microsoft-edge-dev"
else
    remove "/etc/apt/sources.list.d/microsoft-edge.list"
fi

if prompt "Install Microsoft Visual Studio Code repositories? (y/N)"; then
    copy "$FILES/etc/apt/preferences.d/microsoft-vscode" "/etc/apt/preferences.d/microsoft-vscode"
    copy "$FILES/etc/apt/sources.list.d/microsoft-vscode.list" "/etc/apt/sources.list.d/microsoft-vscode.list"

    # Install repository-specific keyring
    copy "$FILES/usr/local/share/keyrings/microsoft.gpg" "/usr/local/share/keyrings/microsoft.gpg"

    # VSCode will look for a vscode.list file, but we want to manage
    # things manually, so ensure it's empty.
    echo >"/etc/apt/sources.list.d/vscode.list"
else
    remove "/etc/apt/sources.list.d/microsoft-vscode.list"
fi

if prompt "Install NodeSource repositories? (y/N)"; then
    copy "$FILES/etc/apt/preferences.d/nodesource" "/etc/apt/preferences.d/nodesource"
    copy "$FILES/etc/apt/sources.list.d/nodesource.list" "/etc/apt/sources.list.d/nodesource.list"

    # Install repository-specific keyring
    copy "$FILES/usr/local/share/keyrings/nodesource.gpg" "/usr/local/share/keyrings/nodesource.gpg"
else
    remove "/etc/apt/sources.list.d/nodesource.list"
fi

if prompt "Install Yarnpkg repositories? (y/N)"; then
    copy "$FILES/etc/apt/preferences.d/yarnpkg" "/etc/apt/preferences.d/yarnpkg"
    copy "$FILES/etc/apt/sources.list.d/yarnpkg.list" "/etc/apt/sources.list.d/yarnpkg.list"

    # Install repository-specific keyring
    copy "$FILES/usr/local/share/keyrings/yarnpkg.gpg" "/usr/local/share/keyrings/yarnpkg.gpg"
else
    remove "/etc/apt/sources.list.d/yarnpkg.list"
fi

echo
echo "==> system installation completed successfully"
