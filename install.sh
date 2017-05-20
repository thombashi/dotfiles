#!/usr/bin/env bash

dotfiles=(
    .bash_profile
    .bashrc
    .functions.sh
    .inputrc
    .nanorc
)
bkp_dir=~/.dotfiles_bkp


\mkdir -p ${bkp_dir}

for dotfile in "${dotfiles[@]}"; do
    dst_path=~/${dotfile}
    bkp_path=${bkp_dir}/${dotfile}

    # backup existing dotfiles
    if [ -e ${dst_path} ] ; then
        cmp -s ${dotfile} ${dst_path}
        if [ "$?" != "0" ] ; then
            \cp -afv ${dst_path} ${bkp_path}
        fi
    fi

    \cp -afv ${dotfile} ${dst_path}
done
