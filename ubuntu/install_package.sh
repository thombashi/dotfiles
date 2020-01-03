#!/usr/bin/env bash

if [ $UID -ne 0 ]; then
    echo 'requires superuser privilege' 1>&2
    exit 13
fi

# https://github.com/golang/go/wiki/Ubuntu
add-apt-repository -y --no-update ppa:longsleep/golang-backports

# https://launchpad.net/~byobu/+archive/ubuntu/ppa
add-apt-repository -y --no-update ppa:byobu/ppa

# https://github.com/jesseduffield/lazygit
add-apt-repository -y --no-update ppa:lazygit-team/release

packages=(
    p7zip-full
    bats
    build-essential
    byobu
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
    lazygit
    moreutils
    nmap
    npm
    openjdk-8-jdk-headless
    pandoc
    peco
    resolvconf
    silversearcher-ag
    shellcheck
    snapd
    source-highlight
    sqlite3
    sysstat
    tree
    unzip
    wget
)
optional_packages=(
    cscope
)

apt update
apt -y install --no-install-recommends "${packages[@]}"
#apt -y install "${optional_packages[@]}"
