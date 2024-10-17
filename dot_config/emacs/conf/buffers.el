;; -*- lexical-binding: t -*-


(general-def
  :states 'normal
  :prefix "<leader> b"
  :prefix-command 'Buffers
  "i" '("Ibuffer project" . projectile-ibuffer)
  "w" '("Ibuffer" . ibuffer)
  "l" '("Buffer list" . consult-buffer)
  "r" '("Rename buffer" . rename-buffer)
  "f" '("Rename buffer and file" . crux-rename-buffer-and-file)
  )
(use-package casual-ibuffer
  :general
  (general-def
    :states 'normal
    :keymaps 'ibuffer-mode-map
    "C-o" '("Transient ibuffer" . casual-ibuffer-tmenu)))

(use-package popwin
  :config
  (popwin-mode 1)
  :init
  (setq popwin:special-display-config '(("*Miniedit Help*" :noselect t)
				       (help-mode :stick t)
				       (completion-list-mode :noselect t)
				       (compilation-mode :noselect t :stick t)
				       (grep-mode :noselect t)
				       (occur-mode :noselect t)
				       ("*Pp Macroexpand Output*" :noselect t)
				       ("*Async Shell Command*" :noselect t)
				       "*Shell Command Output*" "*vc-diff*" "*vc-change-log*"
				       (" *undo-tree*" :width 60 :position right)
				       ("^\\*anything.*\\*$" :regexp t)
				       "*slime-apropos*" "*slime-macroexpansion*" "*slime-description*"
				       ("*slime-compilation*" :noselect t)
				       "*slime-xref*"
				       (sldb-mode :stick t)
				       slime-repl-mode slime-connection-list-mode)

	)
  )

;; (defun maybe-quit ()
;;   (when (string= (buffer-name) "*Async Shell Command*")
;;     (quit-window)))

;; (general-def
;;   :states 'normal
;;   :)
;; (add-hook 'shell-mode-hook #'maybe-set-quit-key)
