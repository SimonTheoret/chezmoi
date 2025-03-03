;; -*- lexical-binding: t -*-



(use-package rust-mode
  :config
  (setq  rust-ts-mode--font-lock-settings
	 (append rust-ts-mode--font-lock-settings
		 ;; constants
		 (treesit-font-lock-rules
		  :feature 'custom
		  :language 'rust
		  :override nil
		  '(
		    (lifetime "'" @font-lock-keyword-face)
		    )
		  )
		 (treesit-font-lock-rules
		  :feature 'custom
		  :language 'rust
		  :override nil
		  '(
		    (lifetime
		     (identifier) @font-lock-keyword-face)
		    )
		  )
		 (treesit-font-lock-rules
		  :feature 'custom
		  :language 'rust
		  :override nil
		  '("(
		     lifetime
		     (identifier) @font-lock-keyword-face
		     (#any-of? @font-lock-keyword-face "static" "_")
		     )")
		  )

		 (treesit-font-lock-rules
		  :feature 'custom
		  :language 'rust
		  :override nil
		  '(
		    "((identifier) @constant.builtin
		     (#any-of? @constant.builtin "Some" "None" "Ok" "Err"))"

		    )
		  )
		 
		 )

	 )
  )
