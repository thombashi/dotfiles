#!/usr/bin/env bash

# Reference:
#   Get Docker CE for Ubuntu | Docker Documentation]
#   https://docs.docker.com/install/linux/docker-ce/ubuntu/

if [ $UID -ne 0 ]; then
    echo 'requires superuser privilege' 1>&2
    exit 13
fi

# Install packages to allow apt to use a repository over HTTPS:
https_packages=(
    apt-transport-https
    ca-certificates
    curl
    software-properties-common
)

apt update
apt -y install "${https_packages[@]}"

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Set up the stable Docker repository
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

apt update

# Install Docker CE
apt install docker-ce
