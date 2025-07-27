;; -*- lexical-binding: t -*-

;; Makes emacs write code in my place

;; ;; Company Completion
;; (use-package company
;;   :defer 0.5
;;   :init
;;   (add-hook 'after-init-hook 'global-company-mode)
;;   :config
;;   (setq company-minimum-prefix-length 3)
;;   (setq company-idle-delay 0.100)
;;   (setq company-backends '((company-capf  company-files company-keywords :with company-yasnippet)))
;;   :general-config
;;   (general-def company-active-map
;;     "<backtab>" (lambda () (interactive) (company-complete-common-or-cycle -1))
;;     "S-TAB" (lambda () (interactive) (company-complete-common-or-cycle -1))
;;     "TAB" #'company-complete-common-or-cycle
;;     "<tab>" #'company-complete-common-or-cycle
;;     "RET" #'newline
;;     "<return>" #'newline
;;     "C-<return>" #'company-complete-selection
;;     "C-<RET>" #'company-complete-selection
;;     "C-b" #'company-complete-selection
;;     "C-w" #'evil-delete-backward-word
;;     )
;;   :general
;;   (general-def
;;     :states 'insert
;;     "C-x C-f" '("Complete files". company-files)
;;     )
;;   )

(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  :defer 0.5
  :general
  (general-def
    :states 'insert
    :map corfu-mode-map
    "C-b" '("Complete" . corfu-complete))
  :init

  ;; Recommended: Enable Corfu globally.  Recommended since many modes provide
  ;; Capfs and Dabbrev can be used globally (M-/).  See also the customization
  ;; variable `global-corfu-modes' to exclude certain modes.
  (global-corfu-mode)

  ;; Enable optional extension modes:
  ;; (corfu-history-mode)
  ;; (corfu-popupinfo-mode)
  )


(use-package corfu-terminal
  :after corfu
  :straight '(
	      :type git
	      :repo "https://codeberg.org/akib/emacs-corfu-terminal.git"))


(unless (display-graphic-p)
  (corfu-terminal-mode +1))

;; Add extensions
(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :after corfu
  :general
  (general-def
    :states 'insert
    "C-x C-f" '("Complete file" . cape-file))
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
  )


;; (use-package company-quickhelp
;;   :after company
;;   :config
;;   (setq company-quickhelp-delay 1)
;;   :hook
;;   (company-mode . company-quickhelp-mode))

;; Snippets
(use-package yasnippet
  :defer 0.5
  :init
  (yas-global-mode 1)
  :general
  (general-def
    :states 'normal
    :prefix "<leader> i"
    :prefix-command 'Insert
    "s" '("Insert snippet" . yas-insert-snippet)))

(use-package yasnippet-snippets
  :after yasnippet
  :config
  (evil-global-set-key 'normal (kbd "<leader> i s") 'yas-insert-snippet))

(use-package doom-snippets
  :after yasnippet
  :straight (doom-snippets :type git :host github :repo "doomemacs/snippets" :files ("*.el" "*")))


(use-package emacs
  :custom
  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))
