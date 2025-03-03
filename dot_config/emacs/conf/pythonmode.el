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
		 ;; constants
		 (treesit-font-lock-rules
		  :feature 'custom
		  :language 'python
		  :override nil
		  '(
		    ((identifier) @font-lock-constant-face
		     (:match "^_?[A-Z][A-Z_0-9]*$" @font-lock-constant-face))
		    )
		  ;; ;; imports
		  ;; :feature 'custom
		  ;; :language 'python
		  ;; :override nil
		  ;; '(
		  ;;   (import_statement name:
		  ;; 		      (dotted_name (identifier) @font-lock-constant-face))
		  ;;   )
		  ;; ;; import with alias 
		  ;; :feature 'custom
		  ;; :language 'python
		  ;; :override nil
		  ;; '(
		  ;;   "(import_statement
                  ;;      name: (aliased_import
                  ;;        name: (dotted_name
                  ;;          (identifier) @module)
                  ;;        alias: (identifier) @module))")
		  ;; ;; import from 
		  ;; :feature 'custom
		  ;; :language 'python
		  ;; :override nil
		  ;; '(
		  ;;   (import_from_statement module_name:
		  ;; 			   (dotted_name (identifier)
		  ;; 					@font-lock-constant-face))
		  ;;   )
		  ;; ;; import from 
		  ;; :feature 'custom
		  ;; :language 'python
		  ;; :override nil
		  ;; '(
		  ;;   (import_from_statement module_name:
		  ;; 			   (relative_import
		  ;; 			    (dotted_name (identifier) @font-lock-constant-face)))
		  ;;   )
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
