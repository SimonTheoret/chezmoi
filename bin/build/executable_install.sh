#!/usr/bin/env fish

#TODO: Add fzf installation

set -e
echo "Installing dev environment"
echo "Abort now if unintended"
sleep 5

cd "$HOME"/bin
command -v fish
command -v npm
command -v go
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source "$HOME/.cargo/env.fish" || . "$HOME/.cargo/env"
export RUSTFLAGS='-C target-cpu=native'
command -v cargo
cargo install --locked bat --force
cargo install eza --force
cargo install fd-find --force
cargo install zoxide --locked --force
cargo install starship --locked --force
cargo install ripgrep --force
cargo install --locked yazi-fm yazi-cli --force
cargo install --locked zellij --force
cargo install --locked tree-sitter-cli --force
cargo install git-delta --force
cargo install mcfly --force
cargo install emacs-lsp-booster --force
cargo install --locked yazi-fm yazi-cli --force
cargo install shellharden --force
cargo install --locked csview --force
cargo install --git https://github.com/jgavris/rs-git-fsmonitor.git --force
cargo install scooter --force
cargo install cargo-nextest --locked --force
cargo install aichat --force
cargo install cargo-insta --locked --force
cargo install just --force
cargo install du-dust --force

sudo npm install -g tldr
sudo npm i -g bash-language-server
npm install -g @anthropic-ai/claude-code

go install github.com/jesseduffield/lazygit@latest
go install github.com/jesseduffield/lazydocker@latest
go install mvdan.cc/sh/v3/cmd/shfmt@latest

curl -LsSf https://astral.sh/uv/install.sh | sh

echo "Installing latest neovim"
./nvim.sh

# wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
# tar -xzf nvim-linux-x86_64.tar.gz
# mv nvim-linux-x86_64 ~/bin/nvim-linux-x86_64

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

. "$HOME"/.config/fish/config.fish
fisher install gazorby/fifc

curl -sfL https://direnv.net/install.sh | bash

./build_helix.sh

