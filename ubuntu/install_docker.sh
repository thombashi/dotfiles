#!/usr/bin/env bash

# Reference:
#   Install Docker Engine on Ubuntu | Docker Documentation
#   https://docs.docker.com/engine/install/ubuntu/
#   (x86_64 / amd64)

if [ $UID -ne 0 ]; then
    echo 'requires superuser privilege' 1>&2
    exit 13
fi

# Uninstall older versions of Docker
apt-get remove -qq docker docker-engine docker.io containerd runc

# Install packages to allow apt to use a repository over HTTPS:
apt-get -qq update
apt-get -qq install --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get -qq update

# Install Docker CE
apt-get -qq install --no-install-recommends docker-ce docker-ce-cli containerd.io

# Reference:
#   Post-installation steps for Linux | Docker Documentation
#   https://docs.docker.com/install/linux/linux-postinstall/

# Manage Docker as a non-root user
groupadd docker

echo
echo "complete installation"
echo "execute docker commands w/ not a super-user, you need to execute:"
echo "  gpasswd -a $USER docker"
