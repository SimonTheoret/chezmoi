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
  )

(general-def
  :states 'normal
  :prefix "<leader> t"
  :prefix-command 'Term
  "t" '("Toggle shell" . shell)
  "T" '("Open shell other window" . shell-other-window)
  "b" '("Open terminal" . term)
  "e" '("Open eat" . eat)
  "E" '("Open eat other window" . eat-other-window)
  "a" '("Open ansi-term" . ansi-term)
  )
