;; -*- lexical-binding: t -*-


;; (defun my--python-ts-highlight ()
;;   (
;;    )
;;   (unless (member 'constant-value (nth 2 treesit-font-lock-feature-list))
;;     (push 'constant-value (nth 2 treesit-font-lock-feature-list)))
;;   )


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
		     (:match "^_?[A-Z][A-Z_0-9]*$" @font-lock-constant-face))
		    )

		  :feature 'custom
		  :language 'python
		  :override t
		  "(identifier) @font-lock-constant-face
		    (#match? @font-lock-constant-face \"^__[a-zA-Z0-9_]*__$\")" ;; OK

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
