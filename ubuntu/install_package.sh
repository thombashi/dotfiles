#!/usr/bin/env bash

if [ $UID -ne 0 ]; then
    echo 'requires superuser privilege' 1>&2
    exit 13
fi

# https://github.com/golang/go/wiki/Ubuntu
add-apt-repository -y --no-update ppa:longsleep/golang-backports

# https://launchpad.net/~byobu/+archive/ubuntu/ppa
add-apt-repository -y --no-update ppa:byobu/ppa

# https://github.com/jesseduffield/lazygit
add-apt-repository -y --no-update ppa:lazygit-team/release

# https://launchpad.net/~git-core/+archive/ubuntu/ppa
apt-add-repository -y --no-update ppa:git-core/ppa

# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
apt-add-repository https://cli.github.com/packages

packages=(
    p7zip-full
    bats
    build-essential
    byobu
    clang-format
    cmake
    colordiff
    curl
    fontconfig
    fonts-firacode
    gawk
    gdb
    gh
    git
    gpgv2
    golang-go
    fping
    httping
    jq
    lazygit
    moreutils
    nmap
    openjdk-8-jdk-headless
    pandoc
    peco
    resolvconf
    silversearcher-ag
    snapd
    source-highlight
    sqlite3
    sshpass
    sysstat
    tree
    unzip
    wget
)
optional_packages=(
    cscope
)

apt update
apt -y install --no-install-recommends "${packages[@]}"
#apt -y install "${optional_packages[@]}"

if ! uname -r | \grep -q Microsoft ; then
    snap install micro --classic
    snap install snapcraft --classic
    snap install circleci shellcheck travis yq
else
    apt -y install --no-install-recommends shellcheck
fi

# install the latest lts npm
if ! n lts --version > /dev/null 2>&1; then
    apt -y install --no-install-recommends npm
    npm install -g n
    n lts
    apt purge nodejs npm -y --autoremove
fi

go get -u github.com/justjanne/powerline-go
