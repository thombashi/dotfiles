#!/usr/bin/env bash

if [ $UID -ne 0 ]; then
    echo 'requires superuser privilege' 1>&2
    exit 13
fi

# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0

apt_repositories=(
    https://cli.github.com/packages  # https://github.com/cli/cli/blob/trunk/docs/install_linux.md
)
ppa_repositories=(
    ppa:byobu/ppa  # https://launchpad.net/~byobu/+archive/ubuntu/ppa
    ppa:git-core/ppa  # https://launchpad.net/~git-core/+archive/ubuntu/ppa
    ppa:longsleep/golang-backports  # https://github.com/golang/go/wiki/Ubuntu
)

for repository in "${apt_repositories[@]}"; do
    add-apt-repository -y "$repository"
done

if lsb_release --id | \grep -q Ubuntu; then
    for repository in "${ppa_repositories[@]}"; do
        add-apt-repository -y --no-update "$repository"
    done
fi

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
    moreutils
    nmap
    openjdk-11-jdk-headless
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

apt update -qq
apt -qq -y install --no-install-recommends "${packages[@]}"
#apt -qq -y install "${optional_packages[@]}"

if ! uname -r | \grep -q Microsoft; then
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

GO111MODULE=on go get -u github.com/jesseduffield/lazygit
GO111MODULE=on go get -u github.com/justjanne/powerline-go
GO111MODULE=on go get -u mvdan.cc/sh/v3/cmd/shfmt
