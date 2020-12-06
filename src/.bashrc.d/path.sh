#!/usr/bin/env bash

# Return exit status of failed command in pipeline
set -o pipefail

# Exit on unbound variables to ensure they are handled correctly.
# This is useful for diagnostics, but can't be left enabled
# because other scripts may rely on the default behavior.
#set -o nounset

path=()

# Add a directory to path if it exists
add_if_exist () {
    if [ -d "$1" ]; then
        path+=("$1")
    fi
}

# Locally-installed scripts and utilities
add_if_exist "${HOME}/.bin"

# Node.js scripts
add_if_exist "${HOME}/.npm-packages/bin"

OS=$(uname --operating-system)

# Running under mingw64, check for other software
if [ "$OS" = "Msys" ]; then
    add_if_exist "/mingw64/bin"
    add_if_exist "/cmd"

    ProgramData="$(cygpath --folder 35)"
    ProgramFiles="$(cygpath --folder 38)"
    ProgramFiles_x86="$(cygpath --folder 42)"

    add_if_exist "${ProgramFiles}/Go/bin"

    add_if_exist "${ProgramFiles}/LLVM/bin"

    add_if_exist "${ProgramData}/Miniconda3/Library/bin"
    add_if_exist "${ProgramData}/Miniconda3/Scripts"
    add_if_exist "${ProgramData}/Miniconda3"

    add_if_exist "${ProgramFiles}/nodejs"

    add_if_exist "${ProgramFiles}/MiKTeX 2.9/miktex/bin/x64"

    add_if_exist "${ProgramFiles_x86}/Yarn/bin"

    add_if_exist "${ProgramFiles_x86}/Google/Cloud SDK/google-cloud-sdk/bin"
fi

# Go programs
if command -v go >/dev/null 2>&1; then
    if [ "$OS" = "Msys" ]; then
        add_if_exist "${HOME}/go/bin"
    else
        add_if_exist "${HOME}/.go/bin"
    fi
fi

# Google Cloud SDK bundled python
if command -v gcloud >/dev/null 2>&1; then
    if [ "$OS" = "Msys" ]; then
        CLOUDSDK_PYTHON="${ProgramFiles_x86}/Google/Cloud SDK/google-cloud-sdk/platform/bundledpython/python.exe"
        export CLOUDSDK_PYTHON
    fi
fi

# Set up conda paths if installed
if command -v conda >/dev/null 2>&1; then
    if [ "$OS" = "Msys" ]; then
        # Suppress linting for files provided by conda
        # shellcheck disable=SC1090,SC1091
        source "${ProgramData}/Miniconda3/etc/profile.d/conda.sh"
    fi
fi

# Site-specific binaries
add_if_exist "/usr/local/bin"

# Vendor binaries: on systems with a separate /usr/bin
if [ ! /bin -ef /usr/bin ]; then
  path+=('/usr/bin')
fi

# Vendor binaries
add_if_exist "/bin"

# Join array elements using : as a separator
PATH=$(IFS=":" && echo "${path[*]}")
export PATH
