#!/usr/bin/env bash

# References:
#   Install Docker Engine on Ubuntu | Docker Docs
#   https://docs.docker.com/engine/install/ubuntu/

if [ $UID -ne 0 ]; then
    echo 'requires superuser privilege' 1>&2
    exit 13
fi

# Uninstall older versions of Docker
apt-get remove -qq \
    docker.io \
    docker-doc \
    docker-compose \
    docker-compose-v2 \
    podman-docker \
    containerd \
    runc

# Install packages to allow apt to use a repository over HTTPS:
apt-get -qq update
apt-get -qq install --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \

# Add Docker’s official GPG key:
apt-get -qq update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get -qq update

# Install Docker Engine
apt-get install --no-install-recommends docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Reference:
#   Post-installation steps for Linux | Docker Documentation
#   https://docs.docker.com/install/linux/linux-postinstall/

# Manage Docker as a non-root user
groupadd docker

echo
echo "complete installation"
echo "execute docker commands w/ not a super-user, you need to execute:"
echo "  gpasswd -a $USER docker"
echo "  usermod -aG docker $USER"
echo "  newgrp docker"
