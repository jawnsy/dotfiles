#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

PROJECT_ROOT=$(git rev-parse --show-toplevel)

curl_flags=(
    --silent
    --show-error
    --location
)

pushd "$PROJECT_ROOT/files/usr/local/share/keyrings"
    # Google Linux Software repository signing key (Chrome)
    curl "${curl_flags[@]}" "https://dl.google.com/linux/linux_signing_key.pub" | \
        gpg --dearmor --output="google-chrome.gpg"

    # Microsoft repository signing key (Edge and Code)
    curl "${curl_flags[@]}" "https://packages.microsoft.com/keys/microsoft.asc" | \
        gpg --dearmor --output="microsoft.gpg"

    # NodeSource signing key
    curl "${curl_flags[@]}" "https://deb.nodesource.com/gpgkey/nodesource.gpg.key" | \
        gpg --dearmor  --output="nodesource.gpg"

    # Yarnpkg signing key
    curl "${curl_flags[@]}" "https://dl.yarnpkg.com/debian/pubkey.gpg" | \
        gpg --dearmor  --output="yarnpkg.gpg"
popd
