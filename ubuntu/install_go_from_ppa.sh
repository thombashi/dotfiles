#!/bin/sh

set -eu

if [ $(id -u) != 0 ]; then
  echo "please run as root" 1>&2
  exit 1
fi

add-apt-repository -y --no-update ppa:longsleep/golang-backports
apt update -qq
apt -qq -y install --no-install-recommends golang-go
