;; -*- lexical-binding: t -*-

(use-package dape
  ;; :preface
  ;; By default dape shares the same keybinding prefix as `gud'
  ;; If you do not want to use any prefix, set it to nil.
  ;; (setq dape-key-prefix "\C-x\C-a")

  ;; :hook
  ;; Save breakpoints on quit
  ;; (kill-emacs . dape-breakpoint-save)
  ;; Load breakpoints on startup
  ;; (after-init . dape-breakpoint-load)

  ;; :config
  ;; Turn on global bindings for setting breakpoints with mouse
  ;; (dape-breakpoint-global-mode)

  ;; Info buffers to the right
  ;; (setq dape-buffer-window-arrangement 'right)

  ;; Info buffers like gud (gdb-mi)
  ;; (setq dape-buffer-window-arrangement 'gud)
  ;; (setq dape-info-hide-mode-line nil)

  ;; Pulse source line (performance hit)
  ;; (add-hook 'dape-display-source-hook 'pulse-momentary-highlight-one-line)

  ;; Showing inlay hints
  ;; (setq dape-inlay-hints t)

  ;; Save buffers on startup, useful for interpreted languages
  ;; (add-hook 'dape-start-hook (lambda () (save-some-buffers t t)))

  ;; Kill compile buffer on build success
  ;; (add-hook 'dape-compile-hook 'kill-buffer)

  ;; Projectile users
  ;; (setq dape-cwd-function 'projectile-project-root)
  )


;; Debug to add bugs

;; (use-package dap-mode
;;   :config
;;   (require 'dap-python)
;;   ;; if you installed debugpy, you need to set this
;;   ;; https://github.com/emacs-lsp/dap-mode/issues/306
;;   (setq dap-python-debugger 'debugpy)
;;   (require 'dap-gdb-lldb)
;;   (dap-gdb-lldb-setup)
;;   (dap-register-debug-template "Rust::GDB Run Configuration"
;;                                (list :type "gdb"
;;                                      :request "launch"
;;                                      :name "GDB::Run"
;; 				     :gdbpath "rust-gdb"
;;                                      :target nil
;;                                      :cwd nil))
;;   :general
;;   (general-def
;;     :states 'normal
;;     :prefix "<leader> d"
;;     :prefix-command 'Dap
;;     "t" '("Toggle breakpoint" . dap-breakpoint-toggle )
;;     "f" '("Condition for breakpoint" . dap-breakpoint-condition )
;;     "e" '("Eval thing" . dap-eval-thing-at-point)
;;     "n" '("Dap next" . dap-next )
;;     "i" '("Step in" . dap-step-in )
;;     "o" '("Step out" . dap-step-out )
;;     "c" '("Continue" . dap-continue )
;;     "q" '("Quit Dap" . dap-disconnect )
;;     "d" '("Dap debug" . dap-debug )
;;     "r" '("Dap relaunch recent" . dap-debug-recent )
;;     "l" '("Dap relaunch last" . dap-debug-last )
;;     "u" '("Dap ui repl" . dap-ui-repl )
;;     "s" '("Eval string" . dap-eval )
;;     )
;;   )
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
