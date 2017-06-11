# thombashi/dotfiles/.bashrc

# disabled terminal lock(Ctrl+S)/unlock(Ctrl+Q) key map
stty stop undef
stty start undef


# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob


# Prevent logout from the terminal by 'Ctrl+D'
set -o ignoreeof


# command aliases: Linux
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias +x='chmod +x'

alias abspath='readlink -f'
alias date='date --rfc-3339=seconds'
alias df='df -h --portability'
alias less='less --tabs=4'
alias mkdir='mkdir -pv'

grep_options='--with-filename --line-number --color=always'
alias egrep='egrep '$(echo ${grep_options})
alias fgrep='fgrep '$(echo ${grep_options})
alias grep='grep '$(echo ${grep_options})
unset grep_options

ls_options='--color=always --group-directories-first --time-style=long-iso --file-type --human-readable --hide-control-chars'
alias ls='\ls '$(echo ${ls_options})
alias la='\ls -A '$(echo ${ls_options})
alias ll='\ls -l '$(echo ${ls_options})
alias lla='\ls -lA '$(echo ${ls_options})
alias lrt='\ls -lrt '$(echo ${ls_options})
alias lrta='\ls -lrtA '$(echo ${ls_options})
unset ls_options

alias echopath='echo $PATH | tr -s ":" "\n"'


# git aliases
alias gsh='git show'
alias glog='git log'
alias glogp='git log --patch'


# language aliases: Python
alias py='python'
alias pyver='python --version'

## language aliases: Python - pip
if type pip > /dev/null 2>&1; then
    alias pip-local-upgrade='pip install --upgrade --no-index .'
    alias pip-upgrade='pip install --upgrade --no-cache-dir'
fi

## language aliases: Python - pyenv
if [ -e ~/.pyenv ]; then
    alias pyenvver='pyenv version'
    alias pyenvsys='pyenv local system'
    alias pyenv2='pyenv local 2.7.13'
    alias pyenv35='pyenv local 3.5.3'
    alias pyenv36='pyenv local 3.6.1'
    alias pyenv3=pyenv36
fi

## language aliases: Python - pytest-runner
alias pst='python setup.py test'
alias pstv='python setup.py test --addopts -v'
alias pstvv='python setup.py test --addopts -vv'
alias pstrx='python setup.py test --addopts --runxfail'
alias pstrxv='python setup.py test --addopts "--runxfail -v"'
alias pstrxvv='python setup.py test --addopts "--runxfail -vv"'

## language aliases: Python - pytest-watch
if type ptw > /dev/null 2>&1; then
    alias ptw='ptw --onpass "echo passed" --onfail "echo failed"'
fi


# environment variables: general
export LC_ALL=C.UTF-8
export LESS='-R --hilite-search --ignore-case --jump-target=.4 --LONG-PROMPT --HILITE-UNREAD'
export PATH=~/bin:${PATH}
export PS1='[\w]\$ '

## set up LS_COLORS
eval $(dircolors)


# environment variables: history
#   more detailed information for each parameter can be found at man bash

## increase the size limit of history and ~/.bash_history
export HISTSIZE=8192
export HISTFILESIZE=${HISTSIZE}

## does not save uninformative commands as a history
export HISTIGNORE='date:exit:history:ls:la:ll:lla:lrt:lrta:pyver:pwd:which *'

## datetime display format for history: ISO 8601 format
export HISTTIMEFORMAT='[%Y-%m-%dT%T] '  # e.g. [2017-01-01T01:23:45] xxx

## ignore histories for both:
##   (1) commands matching the immediately before history entry
##   (2) commands that starting with space(s)
export HISTCONTROL=ignoreboth

# environment variables: distribution dependent

## set up LS_COLORS environment variable
eval $(dircolors)

## set up LESSOPEN environment variable
setup_lessopen() {
    local src_hilite_lesspipe_path=$1

    if [ -e "${src_hilite_lesspipe_path}" ]; then
        export LESSOPEN='| '$(echo ${src_hilite_lesspipe_path})' %s'
    else
        # source-highlight package not installed
        unset LESSOPEN
    fi
}

if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    setup_lessopen '/usr/share/source-highlight/src-hilite-lesspipe.sh'
elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
    setup_lessopen '/usr/bin/src-hilite-lesspipe.sh'
else
    unset LESSOPEN
fi

unset setup_lessopen

# environment variables: Python
if [ -e ~/.pyenv ]; then
    PYENV_BIN='~/.pyenv/bin'

    if ! echo "${PATH}" | \fgrep "${PYENV_BIN}" > /dev/null 2>&1 ; then
        export PATH=${PYENV_BIN}:${PATH}

        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi

    unset PYENV_BIN
fi

## won’t try to write .pyc or .pyo files on the import of source modules.
export PYTHONDONTWRITEBYTECODE=1


# share history across multiple consoles
HISTORY_PROMPT_COMMAND='history -a; history -c; history -r'
if ! echo "${PROMPT_COMMAND}" | \fgrep "${HISTORY_PROMPT_COMMAND}" > /dev/null 2>&1 ; then
    export PROMPT_COMMAND=$(echo ${HISTORY_PROMPT_COMMAND})"; $PROMPT_COMMAND"
fi
unset HISTORY_PROMPT_COMMAND

shopt -u histappend
