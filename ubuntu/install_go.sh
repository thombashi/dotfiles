#!/bin/sh

set -eu

if [ $(id -u) != 0 ]; then
  echo "please run as root" 1>&2
  exit 1
fi

if [ $# != 1 ]; then
  echo "Usage: $(basename $0) <GO VERSION>" 1>&2
  exit 1
fi

GO_VERSION=$1
INSTALL_ROOT="/usr/local"
OS=$(uname | tr '[:upper:]' '[:lower:]')
MACHINE=$(uname -m)

if ! echo $GO_VERSION | \grep -P "\d+(\.\d+){2,}"; then
  echo "invalid go version: ${GO_VERSION}" 1>&2
  exit 1
fi

if [ "$MACHINE" = "x86_64" ]; then
  MACHINE="amd64"
fi

rm -rf "${INSTALL_ROOT}/go"
echo "installing golang ${GO_VERSION} to ${INSTALL_ROOT}/go ..."
curl -fsL https://go.dev/dl/go${GO_VERSION}.${OS}-${MACHINE}.tar.gz | tar xzf - -C ${INSTALL_ROOT}
${INSTALL_ROOT}/go/bin/go version
