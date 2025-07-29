#!/usr/bin/env sh

rm -r ~/bin/nvim-linux-x86_64*
rm -r ~/bin/build/nvim-linux-x86_64*
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz
[ -d "~/bin/nvim-linux-x86_64" ] && rm -r ~/bin/nvim-linux-x86_64*
mv ~/bin/build/nvim-linux-x86_64 ~/bin/
