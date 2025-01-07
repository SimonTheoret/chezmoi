;; -*- lexical-binding: t -*-

;; Makes emacs write code in my place
;;
(use-package corfu
  :config
  (setq corfu-auto t
        corfu-auto-delay 0.14
        corfu-auto-prefix 2
        global-corfu-modes
        '((not erc-mode
               circe-mode
               help-mode
               gud-mode
               vterm-mode)
          t)
        corfu-cycle t
        corfu-preselect 'prompt
        corfu-count 16
        corfu-max-width 120
        corfu-on-exact-match nil
        corfu-quit-no-match corfu-quit-at-boundary
        tab-always-indent 'complete)
  :init
  (global-corfu-mode))

(use-package corfu-terminal
  :straight (corfu-terminal
	     :type git
	     :repo "https://codeberg.org/akib/emacs-corfu-terminal.git"))

(unless (display-graphic-p)
  (corfu-terminal-mode +1))

;; Add extensions
(use-package cape
  :bind ("C-c p" . cape-prefix-map) 
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  )


(use-package emacs
  :custom
  (tab-always-indent 'complete)

  (text-mode-ispell-word-completion nil)

  (read-extended-command-predicate #'command-completion-default-include-p))

;; Snippets
(use-package yasnippet
  :init
  (yas-global-mode 1)
  :general
  (general-def
    :states 'normal
    :prefix "<leader> i"
    :prefix-command 'Insert
    "s" '("Insert snippet" . yas-insert-snippet)))

(use-package yasnippet-snippets)

(use-package doom-snippets
  :after yasnippet
  :straight (doom-snippets :type git :host github :repo "doomemacs/snippets" :files ("*.el" "*")))
