#!/usr/bin/env bash

dotfiles=(
    .bash_profile
    .bashrc
    .functions.sh
    .inputrc
    .nanorc
)


for dotfile in "${dotfiles[@]}"; do
    dst_path=~/${dotfile}
    bkp_dir=~/.dotfiles_bkp
    bkp_path=${bkp_dir}/${dotfile}

    if [ ! -e ${bkp_dir} ] ; then
        \mkdir ${bkp_dir}
    fi

    # backup existing dotfiles
    if [ -e ${dst_path} ] ; then
        cmp -s ${dotfile} ${dst_path}
        if [ "$?" != "0" ] ; then
            \cp -afv ${dst_path} ${bkp_path}
        fi
    fi

    \cp -afv ${dotfile} ${dst_path}
done
