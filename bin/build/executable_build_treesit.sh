#!/usr/bin/env sh

set -e
VERSION=$1
git clone https://github.com/tree-sitter/tree-sitter.git
cd tree-sitter
sudo make install
