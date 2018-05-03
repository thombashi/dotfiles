#!/usr/bin/env bash

if [ $UID -ne 0 ]; then
    echo 'requires superuser privilege' 1>&2
    exit 13
fi

packages=(
    libbz2-dev
    libexpat1-dev
    libgdbm-dev
    liblzma-dev
    libncursesw5-dev
    libreadline-dev
    libsqlite3-dev
    libssl-dev
    python-dev
    tk-dev
    zlib1g-dev
)

apt -y install "${packages[@]}"
