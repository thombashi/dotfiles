#!/usr/bin/env bash

dotfiles=(
    .bash_profile
    .bashrc
    .functions.sh
    .inputrc
    .nanorc
)
nano_bkp_dir=~/.nano_bkp


\mkdir -p ${nano_bkp_dir}

for dotfile in "${dotfiles[@]}"; do
    dst_path=~/${dotfile}

    \cp -fv --backup --update ${dotfile} ${dst_path}
done
