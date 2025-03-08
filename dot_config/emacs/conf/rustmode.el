;; -*- lexical-binding: t -*-
(use-package rust-mode
  :defer 1
  :init
  (setq rust-mode-treesitter-derive t))

(use-package rustic
  :defer 1
  :after inheritenv
  :config
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  :custom
  (rustic-cargo-use-last-stored-arguments t))
