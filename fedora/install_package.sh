#!/usr/bin/env bash

packages=(
    bzip2 bzip2-devel
    cmake
    curl
    fish
    gcc
    gcc-c++
    gdb
    git
    jq
    nmap
    openssl-devel
    python-devel
    readline-devel
    ShellCheck
    source-highlight
    sqlite sqlite-devel
    sysstat
    tig
    wget
    zlib-devel
)

for package in "${packages[@]}"; do
    dnf -y install "${package}"
done
