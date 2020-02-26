#!/usr/bin/env bash

# Reference:
#   Get Docker CE for Ubuntu | Docker Documentation
#   https://docs.docker.com/install/linux/docker-ce/ubuntu/
#   (amd64)

if [ $UID -ne 0 ]; then
    echo 'requires superuser privilege' 1>&2
    exit 13
fi


# Uninstall older versions of Docker
apt remove docker docker-engine docker.io

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


# Reference:
#   Post-installation steps for Linux | Docker Documentation
#   https://docs.docker.com/install/linux/linux-postinstall/

# Manage Docker as a non-root user
groupadd docker

echo
echo "complete installation"
echo "execute docker commands w/ not a super-user, you need to execute:" 
echo "  gpasswd -a $USER docker"
