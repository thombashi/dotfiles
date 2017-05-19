#!/usr/bin/env bash

dotfiles=(
    .bash_profile
    .bashrc
    .functions
    .nanorc
)


for dotfile in "${dotfiles[@]}"; do
    dst_path=~/${dotfile}

    # backup existing dotfiles
    if [ -e ${dst_path} ]; then
        \cp -afv ${dst_path} ${dst_path}.bkp
    fi

    \cp -afv ${dotfile} ${dst_path}
done
