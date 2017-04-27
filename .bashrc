# thombashi/dotfiles/.bashrc


# disabled terminal lock(Ctrl+S)/unlock(CTrl+Q) key map
stty stop undef
stty start undef


# command aliases: Linux
alias ..="cd .."
alias ...="cd ../.."
alias +x='chmod +x'

alias date='date --rfc-3339=seconds'
alias df='df -h'
alias less='less --tabs=4'
alias mkdir='mkdir -pv'

grep_options='--with-filename --line-number --color=always'
alias egrep='egrep '$(echo ${grep_options})
alias fgrep='fgrep '$(echo ${grep_options})
alias grep='grep '$(echo ${grep_options})
unset grep_options

ls_options='--color=always --group-directories-first --time-style=long-iso --file-type --human-readable --hide-control-chars'
alias ls='ls '$(echo ${ls_options})
alias la='ls -A '$(echo ${ls_options})
alias ll='ls -l '$(echo ${ls_options})
alias lla='ls -lA '$(echo ${ls_options})
alias lrt='ls -lrt '$(echo ${ls_options})
alias lrta='ls -lrtA '$(echo ${ls_options})
unset ls_options

alias echopath='echo $PATH | tr -s ":" "\n"'

# language aliases: Python
alias py='python'
alias pyver='python --version'

## language aliases: Python - pyenv
alias pyenvsys='pyenv local system'
alias pyenv2='pyenv local 2.7.13'
alias pyenv35='pyenv local 3.5.3'
alias pyenv36='pyenv local 3.6.1'
alias pyenv3=pyenv36

## language aliases: Python - pytest-runner
alias pst='python setup.py test'
alias pstv='python setup.py test --addopts -v'
alias pstvv='python setup.py test --addopts -vv'
alias pstrx='python setup.py test --addopts --runxfail'
alias pstrxv='python setup.py test --addopts "--runxfail -v"'
alias pstrxvv='python setup.py test --addopts "--runxfail -vv"'


# environment variables: general
export LC_ALL=C.UTF-8
export LESS='-R --ignore-case --LONG-PROMPT --HILITE-UNREAD'
export PS1='[\w]\$ '

# environment variables: history
#   more detailed information for each parameter can be found at man bash

## increase the size limit of history and ~/.bash_history
export HISTSIZE=8192
export HISTFILESIZE=${HISTSIZE}

## does not save uninformative commands as a history
export HISTIGNORE='date:exit:history:ls:la:ll:lla:lrt:lrta:pwd:which *'

## history display format
export HISTTIMEFORMAT='[%Y-%m-%dT%T] '

## lines matching the previous history entry to not be saved
export HISTCONTROL=ignoredups

# environment variables: distribution dependent
if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
elif [ -e /etc/fedora-release ] || [ -e /etc/redhat-release ]; then
    export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
else
    unset LESSOPEN
fi


# functions

<< __date2epoch_docstring__
Convert datetime to an epoch time.

example: a datetime to an epoch time
    $ date2epoch "2017-01-01 00:00:00+0900"
    1483196400

example: show current epoc time
    $ date2epoch
    1493254466
__date2epoch_docstring__
date2epoch() {
    if [ "$1" != "" ]; then
        $(which date) +%s -d "$1"
    else
        $(which date) +%s
    fi
}

<< __epoch2date_docstring__
Convert an epoch time to a datetime

example:
    $ epoch2date 1483196400
    2017-01-01 00:00:00+09:00
__epoch2date_docstring__
epoch2date() {
    if [ "$1" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} EPOCH_TIME"
        return 1
    fi

    $(which date) -d @"$1" --rfc-3339=seconds
}

findfile() {
    $(which find) $1 -type f
}

finddir() {
    $(which find) $1 -type d
}

psgrep() {
    local pattern=$1
    local psaux=$(ps aux)

    if [ "${pattern}" = "" ]; then
        echo "Usage: ${FUNCNAME[0]} PATTERN"
        return 1
    fi

    echo -e "${psaux}" | head -1
    echo -e "${psaux}" | $(which egrep) "${pattern}"
}

pssort() {
    local sort_key=$1

    ps aux --sort "${sort_key}" > /dev/null 2>&1
    if [ "$?" -eq 0 ]; then
        local stdout=$(ps aux --sort "${sort_key}")
        echo -e "${stdout}"
    else
        local header=$(echo -e "$(ps aux)" | head -1)
        echo "invalid sort key. valid sort keys are:" ${header,,}
    fi
}

extract() {
    if [ -f "$1" ]; then
        echo "'$1' is not a valid file to extract"
        return 1
    fi

    case "$1" in
        *.tar.bz2)  tar -jxvf "$1"   ;;
        *.tar.gz)   tar -zxvf "$1"   ;;
        *.bz2)      bunzip2 "$1"     ;;
        *.gz)       gunzip "$1"      ;;
        *.tar)      tar -xvf "$1"    ;;
        *.tbz2)     tar -jxvf "$1"   ;;
        *.tgz)      tar -zxvf "$1"   ;;
        *.zip)      unzip "$1"       ;;
        *.ZIP)      unzip "$1"       ;;
        *) echo "'$1' cannot be extracted via extract()"; return 2 ;;
    esac
}

httpserver() {
    local port=$1

    # get Python major version number
    local pymajorver=$(python -c "from __future__ import print_function; import sys; print(sys.version_info[0])")

    if [ "$pymajorver" = "2" ]; then
        python -m SimpleHTTPServer ${port}
    elif [ "$pymajorver" = "3" ]; then
        python -m http.server ${port}
    fi
}
