#!/usr/bin/env bash

if [ "$GOBIN" = "" ]; then
    echo "GOBIN must be set" 1>&2
    exit 13
fi

echo "GOBIN=${GOBIN}"

set -eux

go install github.com/jesseduffield/lazygit@latest
go install github.com/justjanne/powerline-go@latest
go install mvdan.cc/sh/v3/cmd/shfmt@latest
