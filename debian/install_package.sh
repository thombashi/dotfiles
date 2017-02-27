#!/bin/bash

packages=(
    "cmake"
    "git"
    "resolvconf"
    "shellcheck"
    "source-highlight"
)

for package in "${packages[@]}"; do
    aptitude -y install ${package}
done
