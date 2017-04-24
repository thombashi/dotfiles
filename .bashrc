# .bashrc

# disabled terminal lock (Ctrl+S) key map
stty stop undef
stty start undef


# command aliases: Linux
alias ..="cd .."
alias ...="cd ../.."

alias date='date --iso-8601=seconds'
alias df='df -h'
alias less='less --tabs=4'

grepflag='--with-filename --line-number --color=always'
alias egrep='egrep ${grepflag}'
alias fgrep='fgrep ${grepflag}'
alias grep='grep ${grepflag}'

lsflag='--color=always --group-directories-first'
alias ls='ls ${lsflag}'
alias ll='ls -l ${lsflag}'
alias lla='ls -la ${lsflag}'
alias llart='ls -lart ${lsflag}'


# command aliases: Python
alias pyver='python --version'

# command aliases: Python - pyenv
alias pyenvsys='pyenv local system'
alias pyenv2='pyenv local 2.7.13'
alias pyenv35='pyenv local 3.5.3'
alias pyenv36='pyenv local 3.6.1'
alias pyenv3='pyenv local 3.6.1'

# command aliases: Python - pytest-runner
alias pst='python setup.py test'
alias pstv='python setup.py test --addopts -v'
alias pstvv='python setup.py test --addopts -vv'
alias pstrx='python setup.py test --addopts --runxfail'
alias pstrxv='python setup.py test --addopts "--runxfail -v"'
alias pstrxvv='python setup.py test --addopts "--runxfail -vv"'


# environment variables
export LC_ALL=C.UTF-8
export PS1='[\w]\$ '
export LESS="-R --ignore-case --LONG-PROMPT --HILITE-UNREAD"

# environment variables: history
#   more detailed information can be found at man bash
export HISTSIZE=10000  # increase the limit of history size
export HISTFILESIZE=10000  # increase the limit of ~/.bash_history size
export HISTIGNORE="date:history:ls:pwd:which *"  # does not save uninformative commands as a history
export HISTTIMEFORMAT='[%Y-%m-%dT%T] '  # history display format
export HISTCONTROL=ignoredups  # lines matching the previous history entry to not be saved

# environment variables: distribution dependent
if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
    export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
else
    unset LESSOPEN
fi


# functions
psgrep() {
    local psaux=`ps aux`
    local process_name=$1

    echo -e "${psaux}" | head -1
    echo -e "${psaux}" | /usr/bin/grep ${process_name}
}

pssort() {
    local sort_key=$1

    ps aux --sort -${sort_key}
}
