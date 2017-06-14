#!/usr/bin/env bash

set -u


# make backup directory for nano
\mkdir -p ~/.nano_bkp


# install dotfiles
dotfiles=(
    .bash_profile
    .bashrc
    .functions.sh
    .inputrc
    .nanorc
)

for dotfile in "${dotfiles[@]}"; do
    dst_path=~/${dotfile}

    \cp -fv --backup --update ${dotfile} ${dst_path}
done
