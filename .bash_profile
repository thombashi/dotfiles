# thombashi/dotfiles/.bash_profile

dotfiles=(
    .bashrc
    .functions.sh
)
extra_dotfiles_dir=~/.extra_dotfiles


for dotfile in "${dotfiles[@]}"; do
    [ -r ~/${dotfile} ] && [ -f ~/${dotfile} ] && source ~/${dotfile}
done

unset dotfile
unset dotfiles


# loading extra dot files
if [ -e ${extra_dotfiles_dir} ] ; then
    for extra_dotfile in `find ${extra_dotfiles_dir} -type f`; do
        source ${extra_dotfile}
    done
fi

unset extra_dotfile
unset extra_dotfiles_dir
