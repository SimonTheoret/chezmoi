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
  :hook ((prog-mode . corfu-mode)(prog-mode . corfu-echo-mode)
	 (LaTeX-mode . corfu-mode)(LaTeX-mode . corfu-echo-mode)
	 )
  )

(use-package corfu-terminal
  :straight (corfu-terminal
	     :type git
	     :repo "https://codeberg.org/akib/emacs-corfu-terminal.git")
  )

;; (when-eval-after-load 'corfu  lambda () ((unless (display-graphic-p)
;; 				   (corfu-terminal-mode +1)))
;; 		    )

;; Add extensions
;; CAPE is not really a mode. Rather, it provides some useful completion functions for Corfu.
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

(defvar yasnippet-defer-time 1 "'Yasnippet-Defer-Time' is the defer duration for 'yasnippet'")

;; Snippets
(use-package yasnippet
  :defer yasnippet-defer-time
  :hook ((prog-mode . yas-minor-mode) (LaTeX-mode . yas-minor-mode))
  :config (yas-reload-all)
  :general
  (general-def
    :states 'normal
    :prefix "<leader> i"
    :prefix-command 'Insert
    "s" '("Insert snippet" . yas-insert-snippet))
  )

;; Not really a mode
(use-package yasnippet-snippets
  :after yasnippet
  )

;; Not really a mode either
(use-package doom-snippets
  :after yasnippet
  :straight (doom-snippets :type git :host github :repo "doomemacs/snippets" :files ("*.el" "*")))
