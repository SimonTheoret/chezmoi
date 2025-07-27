;; -*- lexical-binding: t -*-


(use-package envrc
  :defer 1
  :init
  (envrc-global-mode)
  :general-config
  (general-def :states
    'normal
    "<leader> e e" '("Reload env vars" . envrc-reload)))

(use-package inheritenv
  :defer 1)
