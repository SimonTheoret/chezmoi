;; -*- lexical-binding: t -*-

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((comment-fill-column . 80)
     '(list-matching-lines-default-context-lines 1)
     (deadgrep-extra-arguments quote
			       ("--no-config --L --hidden"))
     (eval setq consult-ripgrep-args
	   (concat consult-ripgrep-args " -L --hidden ")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
