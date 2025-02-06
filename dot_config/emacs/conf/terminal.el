;; -*- lexical-binding: t -*-


(use-package vterm
  :defer 2
  :init
  (setq vterm-always-compile-module t)
  :config
  (setq vterm-kill-buffer-on-exit t))

(use-package
  vterm-toggle
  :defer 2
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (add-to-list
   'display-buffer-alist
   '((lambda (buffer-or-name _)
       (let ((buffer (get-buffer buffer-or-name)))
         (with-current-buffer buffer
           (or (equal major-mode 'vterm-mode)
               (string-prefix-p
		vterm-buffer-name (buffer-name buffer))))))
     (display-buffer-reuse-window display-buffer-at-bottom)
     ;;(display-buffer-reuse-window display-buffer-in-direction)
     ;;display-buffer-in-direction/direction/dedicated is added in emacs27
     ;;(direction . bottom)
     ;;(dedicated . t) ;dedicated is supported in emacs27
     (reusable-frames . visible) (window-height . 0.3))))

(use-package multi-vterm
  :defer 2
  :config
  (add-hook 'vterm-mode-hook
	    (lambda ()
	      (setq-local evil-insert-state-cursor 'box)
	      (evil-insert-state))))


(use-package eat
  :defer 2
  :straight (eat
	     :type git
	     :host codeberg
	     :repo "akib/emacs-eat"
	     :files ("*.el" ("term" "term/*.el") "*.texi"
		     "*.ti" ("terminfo/e" "terminfo/e/*")
		     ("terminfo/65" "terminfo/65/*")
		     ("integration" "integration/*")
		     (:exclude ".dir-locals.el" "*-tests.el")))
  )



(general-def
  :states 'normal
  :prefix "<leader> t"
  :prefix-command 'Term
  "o" '("Open vterm other window" . multi-vterm)
  "t" '("Toggle vterm" . vterm-toggle)
  "b" '("Open terminal" . term)
  "e" '("Open eat" . eat)
  "a" '("Open ansi-term" . ansi-term)
  "s" '("Shell" . shell)
  "n" '("Next vterm" . multi-vterm-next)
  "p" '("Previous vterm" . multi-vterm-prev)
  )
