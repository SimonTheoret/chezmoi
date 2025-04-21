;; -*- lexical-binding: t -*-



(use-package python
  :straight (:type built-in)
  :config
  (setq  python--treesit-settings
	 (append python--treesit-settings
		 ;; Constants
		 (treesit-font-lock-rules
		  :feature 'custom
		  :language 'python
		  :override t
		  '(
		    ((identifier) @font-lock-constant-face
		     (:match "^[A-Z][A-Z_0-9]*$" @font-lock-constant-face))
		    )

		  ;; Types 
		  :feature 'custom
		  :language 'python
		  :override t
		  '(
		    (
		     (identifier) @font-lock-type-face
		     (:match "^[A-Z].*[a-z]" @font-lock-type-face))
		    )
		  )
		 )

	 )
  )


(use-package lsp-pyright
  :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
  :hook ((python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred)); or lsp-deferred

		      )

	 (python-ts-mode . (lambda ()
                             (require 'lsp-pyright)
                             (lsp-deferred)); or lsp-deferred

			 ))
  )  

