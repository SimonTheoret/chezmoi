;; -*- lexical-binding: t -*-

(defun shell-other-window ()
  "Open a `shell' in a new window."
  (interactive)
  (let ((buf (shell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))

(defun eshell-other-window ()
  "Open a `eshell' in a new window."
  (interactive)
  (let ((buf (eshell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))

(defun eat-other-window ()
  "Open a `eat' in a new window."
  (interactive)
  (let ((buf (eat)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))

(use-package shell
  :straight (:type built-in)
  :config
  (setq-default shell-kill-buffer-on-exit t)
  )


(use-package vterm
  :defer 1.5
  :config
  (setq-default vterm-kill-buffer-on-exit t)
  (setq vterm-timer-delay 0.01)
  ;; :hook
  ;; (evil-insert-state-entry . (lambda () (vterm-reset-cursor-point nil t)))
  )
(add-hook 'evil-insert-state-entry-hook #'vterm-reset-cursor-point nil t)

(use-package eat
  :defer 1.5
  :straight (eat
	     :type git
	     :host codeberg
	     :repo "akib/emacs-eat"
	     :files ("*.el" ("term" "term/*.el") "*.texi"
		     "*.ti" ("terminfo/e" "terminfo/e/*")
		     ("terminfo/65" "terminfo/65/*")
		     ("integration" "integration/*")
		     (:exclude ".dir-locals.el" "*-tests.el")))
  :hook(
	(eshell-load . eat-eshell-mode)
	(eshell-load . eat-eshell-visual-command-mode)
	)
  ;; :init
  ;; (setenv "EAT_FISH_INTEGRATION_DIR" (concat user-emacs-directory "fish_integration"))
  :config
  (setq-default eat-kill-buffer-on-exit t)
  )

(general-def
  :states 'normal
  :prefix "<leader> t"
  :prefix-command 'Term
  "t" '("Toggle eshell" . eshell)
  "T" '("Open eshell other window" . eshell-other-window)
  "b" '("Open terminal" . term)
  "e" '("Open eat" . eat)
  "E" '("Open eat other window" . eat-other-window)
  "a" '("Open ansi-term" . ansi-term)
  "v" '("Open vterm" . vterm)
  "V" '("Open vterm other window" . vterm-other-window)
  )

