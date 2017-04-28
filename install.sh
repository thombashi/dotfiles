#!/usr/bin/env bash

dotfiles=(
    .bash_profile
    .bashrc
    .nanorc
    .functions
)

for dotfile in "${dotfiles[@]}"; do
    cp -af ${dotfile} ~/${dotfile}
done

unset dotfile
unset dotfiles
