;; -*- lexical-binding: t -*-
(use-package rust-mode
  :init
  (setq rust-mode-treesitter-derive t)
  :config
  (setq  rust-ts-mode--font-lock-settings
	 (append rust-ts-mode--font-lock-settings
		 ;; lifetime
		 (treesit-font-lock-rules
		  :feature 'custom
		  :language 'rust
		  :override nil
		  '(
		    (lifetime "'" @font-lock-keyword-face)
		    )
		  ;; lifetime
		  :feature 'custom
		  :language 'rust
		  :override nil
		  '(
		    (lifetime
		     (identifier) @font-lock-keyword-face)
		    )
		  ;; lifetime
		  :feature 'custom
		  :language 'rust
		  :override nil
		  '("(
 		     lifetime
 		     (identifier) @font-lock-keyword-face
                       (#any-of? @font-lock-keyword-face "static" "_")
 		     )")
		  )
		 )
	 )
  )
