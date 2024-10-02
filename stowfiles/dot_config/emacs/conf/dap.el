;; -*- lexical-binding: t -*- 


;; Debug to add bugs

(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
(require 'dap-python)
;; if you installed debugpy, you need to set this
;; https://github.com/emacs-lsp/dap-mode/issues/306
(setq dap-python-debugger 'debugpy)


 
