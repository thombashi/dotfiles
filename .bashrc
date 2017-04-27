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
findfile() {
    find "$1" -type f
}

finddir() {
    find "$1" -type d
}

psgrep() {
    local process_name=$1
    local psaux=$(ps aux)

    if [ "${process_name}" = "" ]; then
        echo "Usage: psgrep PROCESS_NAME"
        return
    fi
    
    echo -e "${psaux}" | head -1
    echo -e "${psaux}" | $(which grep) "${process_name}"
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
