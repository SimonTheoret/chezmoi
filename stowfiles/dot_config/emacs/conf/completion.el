;; -*- lexical-binding: t -*-

;; Makes emacs write code in my place

;; ;; Company Completion
(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.05)
  :general-config
  (general-def company-active-map
    "<backtab>" (lambda () (interactive) (company-complete-common-or-cycle -1))
    "S-TAB" (lambda () (interactive) (company-complete-common-or-cycle -1))
    "TAB" #'company-complete-common-or-cycle
    "<tab>" #'company-complete-common-or-cycle
    "RET" #'newline
    "<return>" #'newline
    "C-<return>" #'company-complete-selection
    "C-b" #'company-complete-selection
    ))
;; (evil-global-set-key 'insert (kbd "TAB") 'company-select-next)
;; (evil-global-set-key 'insert (kbd "S-TAB") 'company-select-previous)
;; (evil-global-set-key 'insert (kbd "C-RET") 'company-complete-common))
;; (with-eval-after-load 'company
;;   (general-def (
;; 		:states 'insert
;; 		"<backtab>" (lambda () (interactive) (company-complete-common-or-cycle -1))
;; 		"<tab>" #'company-complete-common-or-cycle
;; 		       )))
;; (define-key company-active-map
;;             (kbd "<tab>")
;;             #'company-complete-common-or-cycle)
;; (define-key company-active-map
;;             (kbd "<backtab>")
;;             (lambda ()
;;               (interactive)
;;               (company-complete-common-or-cycle -1))))

(use-package company-quickhelp
  :after company
  :config
  (setq company-quickhelp-delay 0)
  :hook
  (company-mode . company-quickhelp-mode))

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
;; :config
;; (evil-global-set-key 'normal (kbd "<leader> i s") 'yas-insert-snippet))

(use-package doom-snippets
  :after yasnippet
  :straight (doom-snippets :type git :host github :repo "doomemacs/snippets" :files ("*.el" "*")))

;; (use-package corfu
;;   ;; Optional customizations
;;   :custom
;;   (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
;;   ;; (corfu-auto t)                 ;; Enable auto completion
;;   (corfu-separator ?\s)          ;; Orderless field separator
;;   ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
;;   ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
;;   ;; (corfu-preview-current nil)    ;; Disable current candidate preview
;;   ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
;;   ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
;;   (corfu-scroll-margin 5)        ;; Use scroll margin
;;   ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
;;   ;; :hook ((prog-mode . corfu-mode)
;;   ;;        (shell-mode . corfu-mode)
;;   ;;        (eshell-mode . corfu-mode))

;;   ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
;;   ;; be used globally (M-/).  See also the customization variable
;;   ;; `global-corfu-modes' to exclude certain modes.
;;   :init
;;   (global-corfu-mode))

;; (add-to-list 'load-path (concat user-emacs-directory "conf/corfu-popupinfo.el"))
;; (require 'corfu-popupinfo (concat user-emacs-directory "conf/corfu-popupinfo.el"))
;; ;; (require 'corfu-popupinfo-mode)
;; ;; (if (not corfu-popupinfo-mode)
;; ;;     ((require 'corfu-popupinfo-mode)
;; ;;      (corfu-popupinfo-mode 1))
;; ;; )

;; (use-package corfu-terminal
;;   :straight (corfu-terminal :type git :repo "https://codeberg.org/akib/emacs-corfu-terminal.git")
;;   )

;; (use-package corfu-candidate-overlay
;;   :straight (:type git
;; 		   :repo "https://code.bsdgeek.org/adam/corfu-candidate-overlay"
;; 		   :files (:defaults "*.el"))
;;   :after corfu
;;   :config
;;   (corfu-candidate-overlay-mode +1)
;;   ;; enable corfu-candidate-overlay mode globally
;;   ;; this relies on having corfu-aut
;;   )

(use-package emacs
  :custom
  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))
