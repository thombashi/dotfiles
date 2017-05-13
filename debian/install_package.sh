#!/usr/bin/env bash

packages=(
    cmake
    curl
    g++
    gcc
    git
    jq
    nmap
    python-dev
    resolvconf
    shellcheck
    source-highlight
    wget
)

aptitude update

for package in "${packages[@]}"; do
    echo "installing ${package}"
    aptitude -y install "${package}"
done
