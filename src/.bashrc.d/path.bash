path=()

# Locally-installed scripts and utilities
if [ -d "${HOME}/.bin" ]; then
  path+=("${HOME}/.bin")
fi

# Node.js scripts
if [ -d "${HOME}/.npm-packages/bin" ]; then
  path+=("${HOME}/.npm-packages/bin")
fi

# Go programs
if command -v go >/dev/null 2>&1; then
  export GOPATH="${HOME}/.go"

  path+=("${GOPATH}/bin")
fi

# Site-specific binaries
path+=('/usr/local/bin')

# Vendor binaries: on systems with a separate /usr/bin
if [ ! /bin -ef /usr/bin ]; then
  path+=('/usr/bin')
fi

# Vendor binaries
path+=('/bin')

# Join array elements using : as a separator
export PATH=$(IFS=":" && echo "${path[*]}")
