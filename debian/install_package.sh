#!/bin/bash -x


if [ $UID -ne 0 ]; then
    echo 'Permission denied' 1>&2
    exit 13
fi

packages=(
    build-essential
    cmake
    colordiff
    curl
    gdb
    git
    httping
    jq
    resolvconf
    source-highlight
    sysstat
    tig
    wget
)
python_build_packages=(
    libbz2-dev
    libdb5.3-dev 
    libexpat1-dev
    libgdbm-dev
    liblzma-dev
    libncurses5-dev
    libncursesw5-dev
    libreadline-dev
    libsqlite3-dev 
    libssl-dev
    python-dev
    tk-dev
    zlib1g-dev
)
optional_packages=(
    cscope
    fish
    nmap
    shellcheck
)

# Add fish nightly builds repository: https://github.com/fish-shell/fish-shell/wiki/Nightly-builds
#echo 'deb http://download.opensuse.org/repositories/shells:/fish:/nightly:/master/Debian_8.0/ /' > /etc/apt/sources.list.d/fish.list 

aptitude update
aptitude -y install "${packages[@]}"
aptitude -y install "${python_build_packages[@]}"
aptitude safe-upgrade
