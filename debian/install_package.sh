#!/usr/bin/env bash

packages=(
    cmake
    curl
    g++
    gcc
    git
    wget
    resolvconf
    shellcheck
    source-highlight
)

aptitude update

for package in "${packages[@]}"; do
    echo "installing ${package}"
    aptitude -y install "${package}"
done
