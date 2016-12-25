# .bashrc


# command aliases
alias ls='ls --color=always'
alias grep='grep --with-filename --line-number --color=always'

alias pyver='python --version'


# Environment variables
export PS1='[\w]\$ '

export LESS='-NMR'


# Environment variables: Fedora
export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
