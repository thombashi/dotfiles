#!/usr/bin/env bash

dotfiles=(
    .bash_profile
    .bashrc
    .nanorc
    .functions.sh
)

for dotfile in "${dotfiles[@]}"; do
    cp -af ${dotfile} ~/${dotfile}
done

unset dotfile
unset dotfiles
