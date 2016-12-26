# .bashrc


# command aliases: Linux
alias ls='ls --color=always'
alias grep='grep --with-filename --line-number --color=always'


# command aliases: Python
alias pyver='python --version'

alias pyenvsys='pyenv local system'
alias pyenv3='pyenv local 3.5.2'

# command aliases: Python - pytest
alias pst='python setup.py test'
alias pstv='python setup.py test --addopts -v'
alias pstvv='python setup.py test --addopts -vv'


# Environment variables
export PS1='[\w]\$ '

export LESS='-NMR'


# Environment variables: Fedora
export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
