#!/usr/bin/env sh

RUNTIME_DIR=~/.config/helix/runtime

echo "Installing Helix editor"
[ -d "helix" ] && rm -rf "helix"
git clone --depth 1 --branch 25.07.1 https://github.com/helix-editor/helix
cd helix
cargo install --path helix-term --locked
[ -d "$RUNTIME_DIR" ] && rm -r "$RUNTIME_DIR"

cp -r $PWD/runtime "$RUNTIME_DIR"
