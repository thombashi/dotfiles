#!/usr/bin/env bash

dotfiles=(
    .bash_profile
    .bashrc
    .nanorc
    .functions.sh
)

for dotfile in "${dotfiles[@]}"; do
    dst_path=~/${dotfile}

    if [ -e ${dst_path} ]; then
        /bin/cp -afv ${dst_path} ${dst_path}.bkp
    fi

    /bin/cp -afv ${dotfile} ${dst_path}
done
