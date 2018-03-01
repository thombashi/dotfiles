#!/usr/bin/env bash

set -u


# make backup directory for nano
\mkdir -p "${HOME}/.nano_bkp"


# install dotfiles
dotfiles=(
    .bash_profile
    .bashrc
    .functions.sh
    .inputrc
    .jupyter
    .nanorc
    git/.gitconfig
    git/.gitignore_global
    python/.pylintrc
)

for dotfile in "${dotfiles[@]}"; do
    dst_path=${HOME}/$(basename "$dotfile")

    \cp -fva --backup --update "$dotfile" "$dst_path"
done

\cp -fv --backup --update dircolors.ansi-universal "${HOME}/.dircolors"


# install commands that included in a bin directory
bin_dir=bin

if [ -e ${bin_dir} ]; then
    install_dir=~/bin

    \mkdir -p ${install_dir}

    for bin_file in $(\find ${bin_dir} -type f -name '*.sh'); do
        full_bin_path=$(\readlink -f "$bin_file")
        ln -s --force "$full_bin_path" ${install_dir}/$(basename "$full_bin_path" .sh)
    done
fi
