# thombashi/dotfiles/.bash_profile

dotfiles=(
    .bashrc
    .functions
)

for dotfile in "${dotfiles[@]}"; do
    [ -r ~/${dotfile} ] && [ -f ~/${dotfile} ] && source ~/${dotfile}
done

unset dotfile
unset dotfiles
