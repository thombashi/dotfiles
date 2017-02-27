#!/bin/bash

packages=(
    "cmake"
    "git"
    "ShellCheck"
    "source-highlight"
)

for package in "${packages[@]}"; do
    dnf -y install ${package}
done
