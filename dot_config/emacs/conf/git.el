;; -*- lexical-binding: t -*-

;; git magic!

;; Ediff
(setq ediff-window-setup-function #'ediff-setup-windows-plain)

;; magit
(use-package
  magit
  :defer 1.5 
  :after evil-collection
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :general-config
  (general-def
    :states 'normal
    :prefix "<leader> g"
    :prefix-command 'Git
    "/" '("Magit" . magit)
    "g" '("Magit" . magit)
    "l" '("Magit status" . magit-log)
    "t" '("Git TimeMachine" . git-timemachine)
    "s s" '("SMerge mode" . smerge-mode)
    "s n" '("SMerge next" . smerge-next)
    "s p" '("SMerge previous" . smerge-prev)
    "s k" '("SMerge keep current" . smerge-keep-current)
    "s l" '("SMerge keep lower" . smerge-keep-lower)
    "s u" '("SMerge keep upper" . smerge-keep-upper)
    "s a" '("SMerge keep all" . smerge-keep-all)
    ))

(use-package magit-todos
  :after magit
  :config (magit-todos-mode 1) (setq magit-todos-exclude-globs '("*.ipynb")))

(use-package git-modes :defer 1)

(use-package git-timemachine :defer 5)

(use-package git-gutter
  :init
  (global-git-gutter-mode +1) 
  :defer 0.5
  :general-config
  (general-def
    :states 'normal
    :prefix "<leader> g h"
    :prefix-command 'Hunks
    "s" '("Stage hunk" . git-gutter:stage-hunk)
    "p" '("Popup hunk" . git-gutter:popup-hunk)
    "r" '("Revert hunk" . git-gutter:revert-hunk)
    )
  )
