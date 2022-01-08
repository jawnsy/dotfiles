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
copy "$FILES/etc/apt/preferences.d/00default" "/etc/apt/preferences.d/00default"
copy "$FILES/etc/apt/preferences.d/debian" "/etc/apt/preferences.d/debian"

make_directory "/etc/apt/sources.list.d"
copy "$FILES/etc/apt/sources.list.d/debian.list" "/etc/apt/sources.list.d/debian.list"

if prompt "Install Google Chrome repositories? (y/N)"; then
    copy "$FILES/etc/apt/preferences.d/google-chrome" "/etc/apt/preferences.d/google-chrome"
    copy "$FILES/etc/apt/sources.list.d/google-chrome.list" "/etc/apt/sources.list.d/google-chrome.list"

    make_directory "/etc/default"
    copy "$FILES/etc/default/google-chrome" "/etc/default/google-chrome"

    make_directory "/usr/local/share/keyrings"
    copy "$FILES/usr/local/share/keyrings/google-chrome.gpg" "/usr/local/share/keyrings/google-chrome.gpg"
else
    remove "/etc/apt/sources.list.d/google-chrome.list"
fi

if prompt "Install Microsoft Visual Studio Code repositories? (y/N)"; then
    copy "$FILES/etc/apt/preferences.d/microsoft-vscode" "/etc/apt/preferences.d/microsoft-vscode"
    copy "$FILES/etc/apt/sources.list.d/microsoft-vscode.list" "/etc/apt/sources.list.d/microsoft-vscode.list"

    make_directory "/usr/local/share/keyrings"
    copy "$FILES/usr/local/share/keyrings/microsoft.gpg" "/usr/local/share/keyrings/microsoft.gpg"
else
    remove "/etc/apt/sources.list.d/microsoft-vscode.list"
fi

echo
echo "==> system installation completed successfully"
