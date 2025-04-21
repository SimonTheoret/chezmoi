#!/usr/bin/env sh

set -e
VERSION=$1
DIRECTORY="https://ftp.gnu.org/pub/gnu/emacs/emacs-$VERSION.tar.xz"

echo "Setup for Emacs, with version $VERSION from $DIRECTORY"

wget $DIRECTORY

tar -axvf emacs-$VERSION.tar.xz

cd emacs-$VERSION
shift 1
./configure "$@"
