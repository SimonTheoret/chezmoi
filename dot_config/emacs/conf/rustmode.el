;; -*- lexical-binding: t -*-
(use-package rust-mode
  :init
  (setq rust-mode-treesitter-derive t))

(use-package rustic
  :config
  (setq rustic-format-on-save nil)
  :custom
  (rustic-cargo-use-last-stored-arguments t))
