;; -*- lexical-binding: t -*-
(use-package rust-mode
  :defer 1
  :init
  (setq rust-mode-treesitter-derive t))

(use-package rustic
  :defer 1
  :config
  (setq rustic-format-on-save t)
  :custom
  (rustic-cargo-use-last-stored-arguments t))
