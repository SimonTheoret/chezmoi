#!/usr/bin/env sh

rm -r ~/bin/codelldb/
wget https://github.com/vadimcn/codelldb/releases/latest/download/codelldb-linux-x64.vsix
unzip ~/bin/codelldb-linux-x64.vsix -d ~/bin/codelldb
rm -r ~/bin/codelldb/
rm -r ~/bin/codelldb-linux-x64.vsix
