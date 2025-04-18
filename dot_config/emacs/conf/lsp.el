;; -*- lexical-binding: t -*-

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

(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq gc-cons-threshold 10000000)
(setq lsp-log-io nil) ; if set to true can cause a performance hit

(use-package lsp-mode
  :defer 1
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq-default lsp-headerline-breadcrumb-enable nil)
  (setq-default lsp-keymap-prefix "<leader> c")
  (setq-default lsp-ui-sideline-enable nil)
  (setq-default lsp-eldoc-enable-hover nil)
  (setq-default lsp-signature-auto-activate nil) ;; you could manually request them via `lsp-signature-activate`
  (setq-default lsp-signature-render-documentation nil)
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
;; (use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user

;; optionally if you want to use debugger
(use-package dap-mode
  :defer 3)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration

;; NOTE: To make the language server functional, I symlinked
;; `language_server.sh` out of the directory, and into the `bin`
;; folder. This folder is on the `PATH` env. var.
;; (use-package elixir-mode
;;   :after (eglot)
;;   :hook
;;   (elixir-mode . eglot-ensure)
;;   (elixir-ts-mode . eglot-ensure)
;;   )

(use-package nix-mode
  :mode "\\.nix\\'")

;; (use-package gleam-ts-mode
;;   :after (eglot)
;;   :mode (rx ".gleam" eos)
;;   :config
;;   (add-to-list 'eglot-server-programs '(nix-mode . ("nil")))
;;   (add-to-list 'eglot-server-programs '(gleam-ts-mode . ("gleam" "lsp")))
;;   (add-to-list 'eglot-server-programs '(gleam-mode . ("gleam" "lsp")))
;;   (projectile-register-project-type 'gleam '("gleam.toml")
;;                                     :project-file "gleam.toml"
;; 				    :compile "gleam build"
;; 				    :test "gleam test"
;; 				    :run "gleam run"
;;                                     :src-dir "src/"
;;                                     :test-dir "test/"
;; 				    :test-suffix "_test")
;;   :hook
;;   (gleam-ts-mode . eglot-ensure)
;;   (gleam-mode . eglot-ensure)
;;   (nix-mode . eglot-ensure)
;;   )

;; (use-package eglot
;;   :defer 1
;;   :straight (:type built-in)
;;   :config
;;   (add-hook 'rust-ts-mode-hook 'eglot-ensure)
;;   (add-hook 'python-ts-mode-hook 'eglot-ensure)
;;   (add-hook 'LaTeX-mode-hook 'eglot-ensure)
;;   (add-to-list 'eglot-stay-out-of 'flymake)
;;   (setq-default eglot-inlay-hints-mode nil)
;;   ;; Disable inlay hints mode by default. Toggle to activate
;;   :hook
;;   (
;;    (eglot-managed-mode . manually-activate-flymake)
;;    (eglot-managed-mode . (lambda () (setq-default eglot-inlay-hints-mode -1) ) )
;;    )
;;   :custom
;;   (eglot-autoshutdown t)  ;; shutdown language server after closing last file
;;   (eglot-confirm-server-initiated-edits nil)  ;; allow edits without confirmation
;;   )

;; ;; Compromise between having no info and too much info
;; (setq eldoc-echo-area-use-multiline-p nil)
;; (setq eldoc-idle-delay 30)

;; (use-package eglot-booster
;;   :straight (eglot-booster :type git :host github :repo "jdtsmith/eglot-booster")
;;   :after eglot
;;   :config
;;   (eglot-booster-mode)
;;   )

;; (use-package flymake
;;   :straight (:type built-in)
;;   :config
;;   :hook
;;   (eglot-mode . flymake-mode)
;;   ;; (add-hook 'eglot-mode-hook 'flymake-mode)
;;   )

;; (use-package flymake-clippy
;;   :hook (rust-mode . flymake-clippy-setup-backend))

;; (defun manually-activate-flymake ()
;;   (add-hook 'flymake-diagnostic-functions #'eglot-flymake-backend nil t)
;;   (flymake-mode 1))

;; (use-package flymake-diagnostic-at-point
;;   :after flymake
;;   :config
;;   (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode)
;;   (setq flymake-diagnostic-at-point-display-diagnostic-function #'flymake-diagnostic-at-point-display-minibuffer)
;;   )

;; (use-package consult-eglot
;;   :after (:all eglot consult))

;; (general-def
;;   :states
;;   'normal
;;   :prefix "<leader> c"
;;   :prefix-command 'Code
;;   "a"
;;   '("Execute action" . eglot-code-actions)
;;   "i"
;;   '("Find implementation" . eglot-find-implementation)
;;   "t"
;;   '("Find type def" . eglot-find-typeDefinition)
;;   "D"
;;   '("Find declaration" . eglot-find-declaration)
;;   "b"
;;   '("Open doc in buffer" . eldoc)
;;   "n"
;;   '("Rename" . eglot-rename)
;;   "f"
;;   '("Format buffer" .  apheleia-format-buffer)
;;   "m"
;;   '("Lsp Imenu" . imenu)
;;   "h"
;;   '("Hinlay hints" . eglot-inlay-hints-mode)
;;   "o"
;;   '("Casual Overlay" . casual-symbol-overlay-tmenu)
;;   "s"
;;   '("Consult search symbols" . consult-eglot-symbols)
;;   "j"
;;   '("Consult IMenu" . consult-imenu)
;;   "S"
;;   '("Eglot search symbols" . xref-find-apropos)
;;   )

;; (general-def
;;   :states
;;   'normal
;;   "K" '("Documentation" . eldoc)
;;   )


;; (general-def
;;   :states
;;   'normal
;;   :prefix "<leader> c e"
;;   :prefix-command 'Errors
;;   "b"
;;   '("Flymake buffer" . flymake-show-buffer-diagnostics)
;;   "a"
;;   '("Flymake project" . flymake-show-project-diagnostics)
;;   )


