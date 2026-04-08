#!/usr/bin/env fish
set -e

cargo install --locked bat --force
cargo install eza --force
cargo install fd-find --force
cargo install zoxide --locked --force
cargo install starship --locked --force
cargo install ripgrep --force
cargo install --locked zellij --force
cargo install --locked tree-sitter-cli --force
cargo install git-delta --force
cargo install --locked --force yazi-build
cargo install shellharden --force
cargo install --locked csview --force
cargo install cargo-nextest --locked --force
cargo install cargo-insta --locked --force
cargo install just --force
cargo install du-dust --force
cargo install skim --no-default-features --features cli
cargo install --locked watchexec-cli
cargo install --locked bacon

sudo npm install -g tldr
sudo npm i -g bash-language-server

go install github.com/jesseduffield/lazygit@latest
go install github.com/jesseduffield/lazydocker@latest
go install mvdan.cc/sh/v3/cmd/shfmt@latest
