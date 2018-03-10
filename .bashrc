unset PROMPT_COMMAND

# disabled terminal lock(Ctrl+S)/unlock(Ctrl+Q) key map
stty stop undef
stty start undef

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Prevent logout from the terminal by 'Ctrl+D'
set -o ignoreeof


# setup PATH
if [ "$(uname -s)" == "Darwin" ] && type brew > /dev/null 2>&1; then
    for brew_package in coreutils findutils gnu-sed gnu-tar; do
        BREW_PKG_PATH=$(brew --prefix $brew_package)

        if ! echo "$PATH" | \grep -F "$BREW_PKG_PATH" > /dev/null 2>&1 ; then
            export PATH=${BREW_PKG_PATH}/libexec/gnubin:${PATH}
            export MANPATH=${BREW_PKG_PATH}/libexec/gnuman:${MANPATH}
        fi
    done

    for brew_package in diffutils gawk grep gzip; do
        BREW_PKG_PATH=$(brew --prefix $brew_package)

        if ! echo "$PATH" | \grep -F "$BREW_PKG_PATH" > /dev/null 2>&1 ; then
            export PATH=${BREW_PKG_PATH}/bin:${PATH}
        fi
    done

    unset BREW_PKG_PATH
fi

if ! echo "${PATH}" | \grep -F "${HOME}/bin " > /dev/null 2>&1 ; then
    if [ -e "${HOME}/bin" ]; then
        export PATH=${HOME}/bin:${PATH}
    fi
fi

# environment variables: general
export LC_ALL=C.UTF-8
export LESS='-R --hilite-search --ignore-case --jump-target=.4 --LONG-PROMPT --HILITE-UNREAD'
export PS1='[\w]\$ '
export TZ='Asia/Tokyo'

## set up LS_COLORS
if [ -e "${HOME}/.dircolors" ]; then
    eval "$(dircolors ${HOME}/.dircolors)"
else
    eval "$(dircolors)"
fi

# environment variables: history
#   more detailed information for each parameter can be found at man bash

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=8192
export HISTFILESIZE=${HISTSIZE}

## does not save uninformative commands as a history
export HISTIGNORE='date:exit:history:ls:la:ll:lla:lrt:lrta:pyver:pwd:which *'

## datetime display format for history: ISO 8601 format
export HISTTIMEFORMAT='[%Y-%m-%dT%T] '  # e.g. [2017-01-01T01:23:45] xxx

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth


# environment variables: distribution dependent

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
if [ -e "${HOME}/.pyenv" ]; then
    PYENV_BIN="${HOME}/.pyenv/bin"

    if ! echo "${PATH}" | \grep -F "${PYENV_BIN}" > /dev/null 2>&1 ; then
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
if ! echo "${PROMPT_COMMAND}" | \grep -F "${HISTORY_PROMPT_COMMAND}" > /dev/null 2>&1 ; then
    export PROMPT_COMMAND=$(echo ${HISTORY_PROMPT_COMMAND})"; $PROMPT_COMMAND"
fi
unset HISTORY_PROMPT_COMMAND

# append to the history file, don't overwrite it
shopt -u histappend


# Load dotfiles
dotfiles=(
    .bash_aliases
    .functions.sh
)
for dotfile in "${dotfiles[@]}"; do
    [ -r "${HOME}/${dotfile}" ] && [ -f "${HOME}/${dotfile}" ] && source "${HOME}/${dotfile}"
done
unset dotfile
unset dotfiles
