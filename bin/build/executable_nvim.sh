#!/usr/bin/env sh

ARCH=$(uname -m)
OS=$(uname)
if [ "$OS" = "Darwin" ]; then
	OS="macos"
else
	OS="linux"
fi
VERSION="nvim-${OS}-${ARCH}"
rm -r "${HOME:?}"/bin/nvim*
rm -r "${HOME:?}"/bin/build/nvim-*
wget "https://github.com/neovim/neovim/releases/latest/download/$VERSION.tar.gz"
tar -xzf "$VERSION.tar.gz"
[ -d "${HOME:?}/bin/$VERSION" ] && rm -r "${HOME:?}/bin/$VERSION*"
mv "${HOME:?}/bin/build/$VERSION" ~/bin/
