# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


unset PROMPT_COMMAND

# disabled terminal lock(Ctrl+S)/unlock(Ctrl+Q) key map
stty stop undef
stty start undef

# Prevent logout from the terminal by 'Ctrl+D'
set -o ignoreeof


# setup PATH
if [ "$(uname -s)" = "Darwin" ] && command -v brew > /dev/null 2>&1; then
    for brew_package in coreutils findutils gnu-sed gnu-tar; do
        BREW_PKG_PATH=$(brew --prefix $brew_package)

        if ! echo "$PATH" | \grep -qF "$BREW_PKG_PATH" ; then
            export PATH=${BREW_PKG_PATH}/libexec/gnubin:${PATH}
            export MANPATH=${BREW_PKG_PATH}/libexec/gnuman:${MANPATH}
        fi
    done

    for brew_package in diffutils gawk grep gzip nano; do
        BREW_PKG_PATH=$(brew --prefix $brew_package)

        if ! echo "$PATH" | \grep -qF "$BREW_PKG_PATH" ; then
            export PATH=${BREW_PKG_PATH}/bin:${PATH}
        fi
    done

    unset BREW_PKG_PATH
fi

for bin_path in "${HOME}/bin" "${HOME}/.local/bin"; do
    if [ -e "$bin_path" ]; then
        if ! echo "${PATH}" | \grep -qF "$bin_path" ; then
            export PATH=${bin_path}:${PATH}
        fi
    fi
done

# environment variables: personal info
export DEBFULLNAME="Tsuyoshi Hombashi"
export DEBEMAIL="tsuyoshi.hombashi@gmail.com"

# environment variables: general
export GPG_TTY=$(tty)
export LANG=C.UTF-8
export LESS='-R --hilite-search --ignore-case --jump-target=.4 --quit-if-one-screen --no-init --LONG-PROMPT --HILITE-UNREAD'
export TZ='Asia/Tokyo'

if command -v nano > /dev/null 2>&1; then
    export EDITOR=nano
elif command -v micro > /dev/null 2>&1; then
    export EDITOR=micro
elif command -v vim > /dev/null 2>&1; then
    export EDITOR=vim
fi

## set up LS_COLORS
if [ -e "${HOME}/.dircolors" ]; then
    eval "$(dircolors ${HOME}/.dircolors)"
else
    eval "$(dircolors)"
fi

# environment variables: history
#   more detailed information for each parameter can be found at man bash

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=16384
export HISTFILESIZE=${HISTSIZE}

## does not save uninformative commands as a history
export HISTIGNORE='date:exit:history:ls:la:ll:lla:lrt:lrta:pyver:pwd:which:histgrep *'

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
export PYTHON_CONFIGURE_OPTS="--enable-shared"

if [ -e "${HOME}/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    PYENV_BIN="${PYENV_ROOT}/bin"

    if ! echo "${PATH}" | \grep -qF "${PYENV_BIN}" ; then
        export PATH=${PYENV_BIN}:${PATH}

        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi

    unset PYENV_BIN
fi

## won’t try to write .pyc or .pyo files on the import of source modules.
export PYTHONDONTWRITEBYTECODE=1


# environment variables: golang
if [ -e "/usr/local/go/bin" ] && ! echo "${PATH}" | \grep -qF "/usr/local/go/bin" ; then
    export PATH=$PATH:/usr/local/go/bin
fi

if command -v go > /dev/null 2>&1 ; then
    export GOPATH=${HOME}/go
    export GO111MODULE=on

    mkdir -p ${GOPATH}

    if ! echo "${PATH}" | \grep -qF "$GOPATH" ; then
        export PATH=${PATH}:${GOPATH}/bin
    fi
fi


# environment variables: gcloud
GCLOUD_DIR="${HOME}/gcloud/google-cloud-sdk"
if [ -e "${GCLOUD_DIR}" ]; then
    GCLOUD_BIN="${GCLOUD_DIR}/bin"

    if ! echo "${PATH}" | \grep -qF "${GCLOUD_BIN}" ; then
        export PATH=${GCLOUD_BIN}:${PATH}
    fi

    unset GCLOUD_BIN
fi

## The next line updates PATH for the Google Cloud SDK.
if [ -f "${GCLOUD_DIR}/path.bash.inc" ]; then . "${GCLOUD_DIR}/path.bash.inc"; fi

## The next line enables shell command completion for gcloud.
if [ -f "${GCLOUD_DIR}/completion.bash.inc" ]; then . "${GCLOUD_DIR}/completion.bash.inc"; fi


# share history across multiple consoles
HISTORY_PROMPT_COMMAND='history -a; history -c; history -r'
if ! echo "${PROMPT_COMMAND}" | \grep -qF "${HISTORY_PROMPT_COMMAND}" ; then
    export PROMPT_COMMAND=$(echo ${HISTORY_PROMPT_COMMAND})"; $PROMPT_COMMAND"
fi
unset HISTORY_PROMPT_COMMAND

# Load dotfiles
dotfiles=(
    .bash_aliases
    .functions.sh
    .docker_aliases
    .secrets
)
for dotfile in "${dotfiles[@]}"; do
    [ -r "${HOME}/${dotfile}" ] && [ -f "${HOME}/${dotfile}" ] && source "${HOME}/${dotfile}"
done
unset dotfile
unset dotfiles


if readlink /proc/$$/exe | \grep -qF bash ; then
    function _update_ps1() {
        PS1="$($GOPATH/bin/powerline-go -mode compatible -hostname-only-if-ssh -modules "venv,vgo,ssh,host,cwd,perms,git,exit,newline,root" -error $?)"
    }

    if [ -f "$GOPATH/bin/powerline-go" ]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    else
        export PS1='\w \$ '  # <locastion> $
    fi

    # Case-insensitive globbing (used in pathname expansion)
    shopt -s nocaseglob

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # append to the history file, don't overwrite it
    shopt -u histappend

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi
elif readlink /proc/$$/exe | \grep -qF zsh ; then
    export PS1='%m: %~ $ '  # <host>: <locastion> $
fi


# environments: k8s
if command -v kubectl > /dev/null 2>&1 ; then
    alias k='kubectl'

    source <(kubectl completion bash)
    complete -o default -F __start_kubectl k
fi

if command -v kind > /dev/null 2>&1 ; then
    source <(kind completion bash)
fi


# environments: GitHub
if command -v gh > /dev/null 2>&1 ; then
    eval "$(gh completion -s bash)"
fi


# environments: asdf
if [ -e "${HOME}/.asdf" ]; then
    source $HOME/.asdf/asdf.sh
    source $HOME/.asdf/completions/asdf.bash
fi
