#!/usr/bin/env bash


update_option=""

if [ "$1" = "--update" ]; then
    update_option="--update"
fi

# make backup directory for nano
\mkdir -p "${HOME}/.nano_bkp"

wget --quiet https://raw.githubusercontent.com/thombashi/docker-alias/master/docker_aliases.sh -O docker_aliases

# install dotfiles
dotfiles=(
    .bash_aliases
    .bash_profile
    .bashrc
    .functions.sh
    .inputrc
    .jupyter
    docker_aliases
    git/.gitconfig
    git/.gitignore_global
    python/.isort.cfg
    python/.pylintrc
)

for dotfile in "${dotfiles[@]}"; do
    dst_path=${HOME}/$(basename "$dotfile")

    \cp -fva --backup $update_option "$dotfile" "$dst_path"
done

# seebi/dircolors-solarized
\cp -fv --backup $update_option dircolors.ansi-universal "${HOME}/.dircolors"


# install commands that included in a bin directory
# bin_dir=bin
#
# if [ -e ${bin_dir} ]; then
#     install_dir=~/bin
#
#     \mkdir -p ${install_dir}
#
#     for bin_file in $(\find ${bin_dir} -type f -name '*.sh'); do
#         full_bin_path=$(\readlink -f "$bin_file")
#         ln -s --force "$full_bin_path" ${install_dir}/$(basename "$full_bin_path" .sh)
#     done
# fi
