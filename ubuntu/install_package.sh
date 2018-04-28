#!/usr/bin/env bash

if [ $UID -ne 0 ]; then
    echo 'requires superuser privilege' 1>&2
    exit 13
fi

packages=(
    p7zip-full
    bats
    build-essential
    cmake
    colordiff
    curl
    gdb
    git
    httping
    jq
    nmap
    openjdk-8-jdk-headless
    resolvconf
    shellcheck
    source-highlight
    sqlite3
    sysstat
    wget
)
python_build_packages=(
    libbz2-dev
    libdb5.3-dev
    libexpat1-dev
    libgdbm-dev
    liblzma-dev
    libncurses5-dev
    libncursesw5-dev
    libreadline-dev
    libsqlite3-dev
    libssl-dev
    python-dev
    tk-dev
    zlib1g-dev
)
optional_packages=(
    cscope
    fish
)

# Add fish nightly builds repository: https://github.com/fish-shell/fish-shell/wiki/Nightly-builds
#echo 'deb http://download.opensuse.org/repositories/shells:/fish:/nightly:/master/Debian_8.0/ /' > /etc/apt/sources.list.d/fish.list

apt update
apt -y install "${packages[@]}"
apt -y install "${python_build_packages[@]}"
#apt -y install "${optional_packages[@]}"
apt upgrade
