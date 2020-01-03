#!/usr/bin/env bash

update_option=""

if [ "$1" = "--update" ]; then
    update_option="--update"
fi

TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" 0 1 2 3 15

wget --quiet https://raw.githubusercontent.com/thombashi/docker-alias/master/docker_aliases.sh -O ${TMP_DIR}/.docker_aliases
wget --quiet https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-universal -O ${TMP_DIR}/.dircolors

# install dotfiles
dotfiles=(
    .bash_aliases
    .bash_profile
    .bashrc
    .functions.sh
    .inputrc
    .jupyter
    ${TMP_DIR}/.docker_aliases
    ${TMP_DIR}/.dircolors
    git/.gitconfig
    git/.gitignore_global
    python/.pylintrc
)

for dotfile in "${dotfiles[@]}"; do
    dst_path=${HOME}/$(basename "$dotfile")

    \cp -fva --backup $update_option "$dotfile" "$dst_path"
done


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
