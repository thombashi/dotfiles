#!/usr/bin/env bash

packages=(
    cmake
    colordiff
    curl
    fish
    g++
    gcc
    gdb
    git
    jq
    nmap
    python-dev
    resolvconf
    shellcheck
    source-highlight
    sysstat
    tig
    sqlite3
    wget
)

# Add fish nightly builds repository: https://github.com/fish-shell/fish-shell/wiki/Nightly-builds
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/nightly:/master/Debian_8.0/ /' > /etc/apt/sources.list.d/fish.list 

aptitude update

for package in "${packages[@]}"; do
    echo "installing ${package}"
    aptitude -y install "${package}"
done
