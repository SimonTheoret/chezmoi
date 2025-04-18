;; -*- lexical-binding: t -*-

(use-package go-mode
  :hook (
	 (go-ts-mode . lsp-deferred)
	 (go-mode . lsp-deferred)
	 )
  )

