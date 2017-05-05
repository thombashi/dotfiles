#!/usr/bin/env bash

packages=(
    cmake
    curl
    gcc
    gcc-c++
    git
    python-devel
    ShellCheck
    source-highlight
    wget
)

for package in "${packages[@]}"; do
    dnf -y install "${package}"
done
