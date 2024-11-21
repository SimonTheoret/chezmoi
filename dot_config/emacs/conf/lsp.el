;; -*- lexical-binding: t -*-
(defun dotfiles--lsp-if-supported ()
  "Run `lsp' if it's a supported mode."
  (unless (or (derived-mode-p 'emacs-lisp-mode) (derived-mode-p 'json-mode))
    (lsp)))

(add-hook 'hack-local-variables-hook
          (lambda () (when (derived-mode-p 'prog-mode) (dotfiles--lsp-if-supported))))

(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

(use-package
  lsp-mode
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  :hook
  ( ;; replace XXX-mode with concrete major-mode(e. g. python--tsmode)
   ;; (python-ts-mode . lsp-deferred) ;;already taken care of
   (go-ts-mode . lsp)
   (rust-ts-mode . lsp) ;;already taken care of
   (sh-mode . lsp)
   ;;(rustic-mode . lsp-deferred) ;;already taken care of
   ;; if you want which-key integration
   (lsp-mode . lsp-enable-which-key-integration)
   (LaTeX-mode . lsp)
   (kill-emacs . lsp-workspace-remove-all-folders)
   )
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-headerline-breadcrumb-enable t)
  (setq lsp-lens-enable nil)
  (lsp-signature-mode t)
  (setq lsp-eldoc-enable-hover t)
  (setq lsp-signature-auto-activate t)
  (setq lsp-signature-render-documentation nil)
  (setq lsp-ui-doc-use-childframe nil)
  (setq lsp-enable-snippet t)
  (setq lsp-enable-suggest-server-download nil)
  ;; (setq lsp-ui-doc-show-with-cursor t)
  ;; (setq lsp-ui-doc-position 'at-point)
  ;; (setq lsp-headerline-breadcrumb-segments '(symbols))
  ;; (setq lsp-ui-doc-include-signature t)
  ;; (setq lsp-ui-doc-max-height 8)
  ;; :global/:workspace/:file
  (setq lsp-modeline-diagnostics-scope :workspace)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-idle-delay 0.250)
  (setq lsp-inlay-hint-enable nil)
  (setq lsp-inlay-hints-mode -1)
  )

;; Make the help buffer smaller
(add-to-list 'display-buffer-alist
             '((lambda (buffer _) (with-current-buffer buffer
				    (seq-some (lambda (mode)
						(derived-mode-p mode))
                                              '(help-mode))))
	       (display-buffer-reuse-window display-buffer-below-selected)
	       (reusable-frames . visible)
	       (window-height . 0.33)))

(general-def
  :states
  'normal
  :prefix "<leader> c"
  :prefix-command 'Code
  "d"
  '("Find definition" . lsp-ui-peek-find-definitions)
  "a"
  '("Execute action" . lsp-execute-code-action)
  "i"
  '("Find implementation" . lsp-find-implementation)
  "t"
  '("Find type def" . lsp-find-type-definition)
  "D"
  '("Find declaration" . lsp-find-declaration)
  "b"
  '("Open doc in buffer" . lsp-describe-thing-at-point)
  "R"
  '("Find reference" . lsp-ui-peek-find-references)
  "n"
  '("Rename" . lsp-rename)
  "f"
  '("Format buffer" .  apheleia-format-buffer)
  "k"
  '("Describe" . lsp-ui-doc-glance)
  "m"
  '("Lsp Imenu" . lsp-ui-imenu)
  "h"
  '("Hinlay hints" . lsp-inlay-hints-mode)
  )

;; This function filters any diagnostics coming from the virtual env of python
(setf lsp-diagnostic-filter (lambda (param work) ;; params is the hash map containing the diagnostics for a single buffer
			      ;; (message "%s" param)
			      (if (string-match (regexp-quote ".venv/") (plist-get param :uri) )
				  (plist-put param :diagnostics [])
				param
				)
			      ))


;; source:
;; (setf lsp-diagnostic-filter (lambda (param work)
;; 			      (puthash "diagnostics"
;; 				       (cl-remove-if (lambda (diag) (gethash "tags" diag))
;; 						     (gethash "diagnostics" param))
;; 				       param)
;; 			      param))


;; (defun smart-lsp-ui-doc ()
;;   (interactive)
;;   (if lsp-ui-doc-frame-mode
;;       ((lsp-ui-doc-show)
;;        (lsp-ui-doc-focus-frame)
;;        (lsp-ui-doc-enable nil))
;;     ((lsp-ui-doc-hide)
;;      (setq lsp-ui-doc-enable t))
;;     )
;;   )

(general-def
  :states
  'normal
  :prefix "<leader> c w"
  :prefix-command 'Workspace
  "d"
  '("LSP Workspace delete" . lsp-workspace-folders-remove)
  "a"
  '("LSP Workspace add" . lsp-workspace-folders-add)
  "r"
  '("LSP restart workspace" . lsp-workspace-restart)
  )

;; optionally
;; By default, lsp-mode automatically activates lsp-ui unless lsp-auto-configure is set to nil.
(use-package lsp-ui :commands lsp-ui-mode)

;;LSP optimizations

(defun lsp-optim ()
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 4 (* 1024 1024))) ;; 1mb
  (setq lsp-use-plists t))

(lsp-optim)

;; Python
(use-package
  lsp-pyright
  :after lsp-mode
  :hook
  (python-ts-mode
   .
   (lambda ()
     (require 'lsp-pyright)
     (lsp)))) ; or lsp-deferred

;; Rust
(use-package rust-mode
  ;;   :mode "\\.rs\\'"
  ;; :hook
  ;; (rust-mode . rustic-mode)
  ;; (rustic-mode . lsp)
  :init
  (setq-default lsp-rust-analyzer-cargo-watch-command "clippy")
  (setq-default lsp-rust-all-features t)
  (setq rust-mode-treesitter-derive t)
  )
(use-package rustic
  :config (setq rustic-format-on-save nil)
  :custom
  (rustic-cargo-use-last-stored-argument t)
  :after (rust-mode))

;; Latex
(use-package
  lsp-latex
  :init (setq lsp-latex-forward-search-executable "zathura")
  (setq lsp-latex-forward-search-args
	'("--synctex-forward" "%l:1:%f" "%p"))
  :hook (tex-mode . lsp) (latex-mode . lsp) (LaTeX-mode . lsp))

;; Go
(use-package
  go-mode
  :config (setq-default lsp-go-use-gofumpt t)
  :hook (go-mode . flycheck-golangci-lint-setup)
  (go-mode . go-guru-hl-identifier-mode))

(use-package go-eldoc :hook (go-mode . go-eldoc-setup))

(use-package flycheck-golangci-lint)

(eval-after-load
    'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))

(use-package casual-symbol-overlay
  :general
  (general-def
    :states 'normal
    :prefix "<leader> c o"
    :prefix-command 'SymbolOverlay
    "m" '("SymbolOverlay mode" . symbol-overlay-mode )
    "p" '("SymbolOverlay put" . symbol-overlay-put )
    "f" '("SymbolOverlay forward" . symbol-overlay-switch-forward )
    "b" '("SymbolOverlay backward" . symbol-overlay-switch-backward )
    "r" '("SymbolOverlay remove" . symbol-overlay-switch-remove-all )
    )
  :bind (:map
         symbol-overlay-map
         ("C-o" . casual-symbol-overlay-tmenu)))


(defun my-reload-dir-locals-for-current-buffer ()
  "reload dir locals for the current buffer"
  (interactive)
  (let ((enable-local-variables :all))
    (hack-dir-local-variables-non-file-buffer)))


(use-package gleam-ts-mode
  :mode (rx ".gleam" eos))
