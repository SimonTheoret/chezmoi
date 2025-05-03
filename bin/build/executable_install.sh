#!/usr/bin/env fish

#TODO: Add fzf installation 

set -e
echo "Installing dev environment"
echo "Abort now if unintended"
sleep 5

cd $HOME/bin
command -v fish
command -v npm
command -v go
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source "$HOME/.cargo/env.fish" || . "$HOME/.cargo/env"

command -v cargo
cargo install --locked bat
cargo install eza
cargo install fd-find
cargo install zoxide --locked
cargo install starship --locked
cargo install ripgrep
cargo install --locked yazi-fm yazi-cli
cargo install --locked zellij
cargo install --locked tree-sitter-cli
cargo install git-delta
cargo install mcfly
cargo install emacs-lsp-booster
cargo install --locked yazi-fm yazi-cli
cargo install shellharden

sudo npm install -g tldr
sudo npm i -g bash-language-server

go install github.com/jesseduffield/lazygit@latest
go install github.com/jesseduffield/lazydocker@latest

curl -LsSf https://astral.sh/uv/install.sh | sh

wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

. $HOME/.config/fish/config.fish
fisher install PatrickF1/fzf.fish

curl -sfL https://direnv.net/install.sh | bash
