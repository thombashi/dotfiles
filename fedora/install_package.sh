#!/usr/bin/env bash

packages=(
    cmake
    curl
    gcc
    gcc-c++
    git
    wget
    ShellCheck
    source-highlight
)

for package in "${packages[@]}"; do
    dnf -y install "${package}"
done
