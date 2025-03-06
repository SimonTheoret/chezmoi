;; -*- lexical-binding: t -*-
;; Now Emacs treats manual buffer switching the same as programmatic
;; switching.
(setq switch-to-buffer-obey-display-actions t)

(customize-set-variable 'display-buffer-base-action '((display-buffer-reuse-window display-buffer-same-window)
						      (reusable-frames . t)))
(customize-set-variable 'even-window-sizes nil)

(setq switch-to-buffer-obey-display-actions t)

(setq switch-to-buffer-in-dedicated-window 'pop)


(add-to-list 'display-buffer-alist
	     '("\\*compilation\\*"
	       (display-buffer-reuse-window display-buffer-in-direction) 
	       (direction . below)
	       (window-height . 0.33)
	       ))

;; TODO: problem: this config does not allow me to move around the compilation buffer
;; (add-to-list 'display-buffer-alist

;; 	       (display-buffer-in-side-window display-buffer-same-window) 
;; 	       (side . bottom)
;; 	       (slot . 0)
;; 	       (window-height . 0.25)
;; 	       (dedicated . nil)
;; 	       ))


(winner-mode)

(general-def
  :states 'normal
  :prefix "<leader> b"
  :prefix-command 'Buffers
  "i" '("Ibuffer project" . projectile-ibuffer)
  "I" '("Ibuffer" . ibuffer)
  "l" '("Buffer project list" . consult-project-buffer)
  "L" '("Buffer list" . consult-buffer)
  "r" '("Rename buffer" . rename-buffer)
  "f" '("Rename buffer and file" . crux-rename-buffer-and-file)
  "d" '("Delete current buffer" . kill-current-buffer)
  "d" '("Delete current buffer and window" . kill-buffer-and-window)
  "s" '("Scratch buffer" . scratch-buffer)
  "n" '("Ibuffer mark by name" . ibuffer-mark-by-file-name-regexp)
  "b" '("Focus current buffer" . delete-other-windows)
  "m" '("Winner undo" . winner-undo)
  )

;; (use-package popwin
;;   :config
;;   (popwin-mode 1)
;;   :init
;;   (setq popwin:special-display-config '(("*Miniedit Help*" :noselect t)
;;   					("*eldoc*" :position bottom :dedicated t )
;;   					;; (help-mode :stick t :position bottom )
;;   					("*Flymake diagnostics for .*/*" :noselect nil :position bottom )
;;   					("*xref*" :noselect nil :position bottom )
;;   					(help-mode :stick t)
;;   					(completion-list-mode :noselect t)
;;   					;; (compilation-mode :noselect t :stick t :position bottom)
;;   					(grep-mode :noselect t)
;;   					(occur-mode :noselect nil)
;;   					("*Pp Macroexpand Output*" :noselect t)
;;   					("*Async Shell Command*" :noselect t)
;;   					"*Shell Command Output*"
;;   					"*vc-diff*" "*vc-change-log*"
;;   					(" *undo-tree*" :width 60 :position right)
;;   					("^\\*anything.*\\*$" :regexp t)
;;   					"*slime-apropos*" "*slime-macroexpansion*" "*slime-description*"
;;   					("*slime-compilation*" :noselect t)
;;   					"*slime-xref*"
;;   					(sldb-mode :stick t)
;;   					slime-repl-mode slime-connection-list-mode)

;;   	)
;;   )
