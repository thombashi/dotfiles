#!/usr/bin/env bash

brew_packages=(
    colordiff
    coreutils
    curl
    diffutils
    findutils
    gawk
    git
    gnu-sed
    gnu-tar
    gzip
    jq
    pandoc
    wget
)

for brew_package in "${brew_packages[@]}"; do
    brew install "$brew_package"
done

brew install grep --with-default-names


# brew cask ------------------------------
brew tap caskroom/cask
brew tap buo/cask-upgrade

brew_cask_packages=(
    docker
    font-fira-code
    sourcetree
    visual-studio-code
)

for brew_cask_package in "${brew_cask_packages[@]}"; do
    brew cask install "$brew_cask_package"
done

brew cu
