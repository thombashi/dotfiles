# .bashrc


# command aliases: Linux
alias ls='ls --color=always'
alias grep='grep --with-filename --line-number --color=always'
alias date='date --iso-8601=seconds'

# command aliases: Python
alias pyver='python --version'

# command aliases: Python - pyenv
alias pyenvsys='pyenv local system'
alias pyenv2='pyenv local 2.7.13'
alias pyenv35='pyenv local 3.5.3'
alias pyenv36='pyenv local 3.6.1'
alias pyenv3='pyenv local 3.6.1'

# command aliases: Python - pytest
alias pst='python setup.py test'
alias pstv='python setup.py test --addopts -v'
alias pstvv='python setup.py test --addopts -vv'
alias pstrx='python setup.py test --addopts --runxfail'
alias pstrxv='python setup.py test --addopts "--runxfail -v"'
alias pstrxvv='python setup.py test --addopts "--runxfail -vv"'


# Environment variables
export PS1='[\w]\$ '

export LESS='-NMR'


# Environment variables: distribution dependent
if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
    export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
else
    unset LESSOPEN
fi
