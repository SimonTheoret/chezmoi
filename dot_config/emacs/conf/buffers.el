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
	     '((major-mode . compilation-mode )
	       ;; '("\\*compilation\\*"
	       (display-buffer-reuse-mode-window display-buffer-at-bottom) 
	       (window-height . 0.33)
	       (dedicated . nil)
	       ))

(add-to-list 'display-buffer-alist
	     '("\\*eldoc\\*"
	       (display-buffer-reuse-mode-window display-buffer-at-bottom) 
	       (window-height . 0.33)
	       (dedicated . nil)
	       ))

(add-to-list 'display-buffer-alist
	     '("\\*xref\\*"
	       (display-buffer-reuse-mode-window display-buffer-at-bottom) 
	       (window-height . 0.33)
	       (post-command-select-window . t)
	       (dedicated . nil)
	       ))

(add-to-list 'display-buffer-alist
	     '("\\*Flymmake diagnostics for .*\\*"
	       (display-buffer-reuse-mode-window display-buffer-at-bottom) 
	       (window-height . 0.33)
	       (dedicated . nil)
	       ))

(add-to-list 'display-buffer-alist
	     '("\\*tldr\\*"
	       (display-buffer-reuse-mode-window display-buffer-in-side-window) 
	       (side . right)
	       (window-width . 0.33)
	       (slot . 0)
	       (dedicated . t)
	       (post-command-select-window . t)
	       ))

(add-to-list 'display-buffer-alist
	     '("\\*Man .*\\*"
	       (display-buffer-reuse-mode-window display-buffer-in-side-window) 
	       (side . right)
	       (window-width . 0.33)
	       (slot . 0)
	       (dedicated . t)
	       (post-command-select-window . t)
	       ))

(add-to-list 'display-buffer-alist
	     '("\\*WoMan .*\\*"
	       (display-buffer-reuse-mode-window display-buffer-in-side-window) 
	       (side . right)
	       (window-width . 0.33)
	       (slot . 0)
	       (dedicated . t)
	       (post-command-select-window . t)
	       ))

(add-to-list 'display-buffer-alist
	     '((major-mode . help-mode)
	       (display-buffer-reuse-mode-window display-buffer-in-side-window) 
	       (side . right)
	       (window-width . 0.33)
	       (slot . 0)
	       (dedicated . t)
	       (post-command-select-window . t)
	       ))

(add-to-list 'display-buffer-alist
	     '("\\*Occur*\\*"
	       (display-buffer-reuse-mode-window display-buffer-at-bottom) 
	       (window-height . 0.33)
	       (post-command-select-window . t)
	       (dedicated . nil)
	       ))

(add-to-list 'display-buffer-alist
	     '("\\*Async Shell Command\\*"
	       (display-buffer-reuse-mode-window display-buffer-at-bottom) 
	       (window-height . 0.33)
	       (dedicated . nil)
	       ))

(add-to-list 'display-buffer-alist
	     '("\\*Shell Command Output\\*"
	       (display-buffer-reuse-mode-window display-buffer-at-bottom) 
	       (window-height . 0.33)
	       (dedicated . nil)
	       ))

(add-to-list 'display-buffer-alist
	     '("\\*grep*\\*"
	       (display-buffer-reuse-mode-window display-buffer-at-bottom) 
	       (window-height . 0.33)
	       (post-command-select-window . t)
	       (dedicated . nil)
	       ))

(use-package popper
  :defer 0.5
  :init
  (setq popper-reference-buffers
        '("Output\\*$"
          "\\*Async Shell Command\\*"
          "\\*Shell Command Output\\*"
	  "\\*WoMan .*\\*"
	  "\\*Man .*\\*"
	  "\\*Flymmake diagnostics for .*\\*"
	  "\\*tldr*\\*"
	  "\\*Flymmake diagnostics for .*\\*"
	  "\\*xref\\*"
	  "\\*eldoc\\*"
          help-mode
	  "\\*Occur*\\*"
	  "\\*grep*\\*"
          compilation-mode))
  (popper-mode +1)
  (setq-default popper-display-control nil) 
  (popper-echo-mode +1)) ; For echo area hints


(winner-mode)

(general-def
  :states 'normal
  :prefix "<leader> b"
  :prefix-command 'Buffers
  "i" '("Ibuffer project" . projectile-ibuffer)
  "I" '("Ibuffer" . ibuffer)
  "l" '("Buffer project list" . consult-project-buffer)
  "L" '("Buffer list" . switch-to-buffer)
  "r" '("Rename buffer" . rename-buffer)
  "f" '("Rename buffer and file" . crux-rename-buffer-and-file)
  "d" '("Delete current buffer" . kill-current-buffer)
  "d" '("Delete current buffer and window" . kill-buffer-and-window)
  "s" '("Scratch buffer" . scratch-buffer)
  "n" '("Ibuffer mark by name" . ibuffer-mark-by-file-name-regexp)
  "b" '("Focus current buffer" . delete-other-windows)
  "m" '("Winner undo" . winner-undo)
  "t" '("Popper toggle" . popper-toggle)
  "c" '("Popper cycle" . popper-cycle)
  "T" '("Popper toggle type" . popper-toggle-type)
  "b" '("Prefix for other window" . other-window-prefix)
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
