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

snap install micro --classic
snap install yq

# install the latest lts npm
if ! n lts --version > /dev/null 2>&1; then
    apt -y install --no-install-recommends npm
    npm install -g n
    n lts
    apt purge nodejs npm -y --autoremove
fi
