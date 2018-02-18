#!/usr/bin/env bash


if [ $UID -ne 0 ]; then
    echo 'Permission denied' 1>&2
    exit 1
fi

packages=(
    bzip2 bzip2-devel
    cmake
    colordiff
    curl
    fish
    gcc
    gcc-c++
    gdb
    git
    httping
    java-1.8.0-openjdk
    jq
    nmap
    nodejs
    openssl-devel
    patch
    python-devel
    psmisc
    readline-devel
    redhat-rpm-config
    ShellCheck
    source-highlight
    sqlite sqlite-devel
    sysstat
    tig
    tk-devel
    sqlite3
    wget
    zlib-devel
)

for package in "${packages[@]}"; do
    dnf -y install "${package}"
done
