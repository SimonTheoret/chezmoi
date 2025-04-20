;; -*- lexical-binding: t -*-

(use-package go-mode
  :defer 1
  :hook (
	 (go-ts-mode . lsp-deferred)
	 (go-mode . lsp-deferred)
	 )
  )
