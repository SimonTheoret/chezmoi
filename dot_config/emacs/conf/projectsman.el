;; -*- lexical-binding: t -*-

;; Projects manager

;; Make use of fd.
(use-package find-file-in-project
  :defer 0.5
  :config
  (setq ffip-use-rust-fd t)
  :general-config
  (general-def
    :states
    'normal
    "<leader> SPC" '("Find file in project" . find-file-in-project-by-selected)
    )
  )

;; Projectile needs project before loading itself
(use-package project
  :straight (:type built-in)
  :defer 0.5
  ;; :config

  :general-config
  (general-def
    :states
    'normal
    :prefix "<leader> p"
    :prefix-command 'Projec
    "p" '("Project switch project" . project-switch-project)
    "d" '("Project remove project" . project-forget-project)
    )
  (general-def
    :states
    'normal
    "<leader> SPC" '("Find file in project" . project-find-file)
    )
  )

(use-package docker
  :defer 1
  :general-config
  (general-def
    :states
    'normal
    :prefix "<leader> d"
    :prefix-command 'Docker
    "d" '("Docker" . docker)
    )
  )


(use-package prodigy
  :defer 5)
;; Define services here
