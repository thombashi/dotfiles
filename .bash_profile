# thombashi/dotfiles/.bash_profile

dotfiles=(
    .bashrc
)

for dotfile in "${dotfiles[@]}"; do
    [ -r "${HOME}/${dotfile}" ] && [ -f "${HOME}/${dotfile}" ] && source "${HOME}/${dotfile}"
done

unset dotfile
unset dotfiles


# loading extra dot files
extra_dotfiles_dir=${HOME}/.extra_dotfiles
if [ -e ${extra_dotfiles_dir} ] ; then
    for extra_dotfile in $(\find ${extra_dotfiles_dir} -type f | \grep -Ev "~$"); do
        source ${extra_dotfile}
    done
fi

unset extra_dotfile
unset extra_dotfiles_dir
