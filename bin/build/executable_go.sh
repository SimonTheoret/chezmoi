#!/usr/bin/env bash

set -e
echo "Setup for Golang"

os_name=$(uname -s)

arch=$(uname -i)
if [ $arch="x84_64" ]; then
    arch="amd64"
fi
version="1.24.3"
file="go${version}.${os_name,,}-${arch,,}.tar.gz"
destination="https://go.dev/dl/${file}"
echo "Download url: ${destination}"
wget "${destination}"

sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ${file}

command -v go
