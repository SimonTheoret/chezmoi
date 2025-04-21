#!/usr/bin/env sh

set -e
echo "Setup for Golang"

rm -rf /usr/local/go && tar -C /usr/local -xzf go1.24.2.linux-amd64.tar.gz

command -v go
