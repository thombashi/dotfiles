#!/usr/bin/env bash

if [ $UID -ne 0 ]; then
    echo 'requires superuser privilege' 1>&2
    exit 13
fi

# https://github.com/golang/go/wiki/Ubuntu
add-apt-repository ppa:longsleep/golang-backports

packages=(
    p7zip-full
    bats
    build-essential
    cmake
    colordiff
    curl
    fontconfig
    gdb
    git
    gpgv2
    golang-go
    fping
    httping
    jq
    nmap
    npm
    openjdk-8-jdk-headless
    pandoc
    resolvconf
    silversearcher-ag
    shellcheck
    source-highlight
    sqlite3
    sysstat
    tree
    tmux
    unzip
    wget
)
optional_packages=(
    cscope
)

apt update
apt -y install "${packages[@]}"
#apt -y install "${optional_packages[@]}"
