# .bashrc

alias ls='ls --color=always'
alias grep='grep --with-filename --line-number --color=always'

export PS1='[\w]\$ '

export LESS='-NMR'

# Fedora
export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
