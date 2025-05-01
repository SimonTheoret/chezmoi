;; -*- lexical-binding: t -*-
(use-package rust-mode
  :defer 1
  :init
  (setq rust-mode-treesitter-derive t)
  )

(use-package rustic
  :defer 1
  :config
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (setq rustic-format-on-save nil)
  :hook
  (rustic-mode . lsp-deferred)
  :custom
  (rustic-cargo-use-last-stored-arguments t)
  )
