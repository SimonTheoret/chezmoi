;; -*- lexical-binding: t -*-

;; Managing perspectives/views

;;TODO: Configure persp to be used by default for selecting buffers, instead of projects
;; persp-mode
(use-package persp-mode
  :defer 0.5
  :custom
  (persp-keymap-prefix (kbd "<leader> TAB"))
  (persp-auto-save-opt 0)
  (persp-auto-resume-time -1)
  (persp-nil-name "main")
  :init
  (persp-mode)
  (setq-default persp-nil-name "main"))

(with-eval-after-load "persp-mode-autoloads"
  (setq persp-autokill-buffer-on-remove 'kill-weak))

