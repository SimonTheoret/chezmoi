;; -*- lexical-binding: t -*-


;; Makes dired goooood

(setq dired-listing-switches "-alh")

(use-package diff-hl :config (global-diff-hl-mode))

(use-package diredfl :config (diredfl-global-mode))

(use-package
  dired-rsync
  :bind (:map dired-mode-map ("<leader> r r" . dired-rsync)))

(use-package
  dired-rsync-transient
  :bind
  (:map dired-mode-map ("<leader> r t" . dired-rsync-transient)))

(use-package casual-dired)

(defun search-emacs-dir ()
  (interactive)
  (ido-find-file-in-dir "~/.local/share/chezmoi/dot_config/emacs/" ))

(defun search-chezmoi-dir ()
  (interactive)
  (ido-find-file-in-dir "~/.local/share/chezmoi" ))

(defun search-home-dir ()
  (interactive)
  (ido-find-file-in-dir "~/" ))

(add-hook 'dired-mode-hook (lambda () (setq display-line-numbers 'relative)))

(general-def
  :states
  'normal
  :prefix "<leader> f"
  :prefix-command 'Files
  "f"
  '("Find files" . ido-find-file)
  "p"
  '("Search conf" . search-emacs-dir)
  "d"
  '("Create dir" . make-directory)
  "D"
  '("Delete directory" . delete-directory)
  "c"
  '("Copy current file" . crux-copy-file-preserve-attributes)
  "e"
  '("sudoedit current file" . crux-sudo-edit)
  "n"
  '("Create empty file" . dired-create-empty-file)
  "b"
  '("Fuzzy search files" . consult-fd)
  "g"
  '("Change current dir" . cd)
  "o"
  '("Dired here" . dired-jump)
  "l"
  '("Chezmoi files" . search-chezmoi-dir)
  "h"
  '("Home files" . search-home-dir)
  )

(general-def
  :states
  'normal
  :keymaps 'dired-mode-map
  "C-o"
  '("Casual dired" .  casual-dired-tmenu)
  )


(general-def
  :states
  'normal
  :prefix "<leader> f m"
  :prefix-command 'Modify
  "n"
  '("Rename current file" . crux-rename-file-and-buffer)
  "d"
  '("Remove file" . delete-file)
  )

(use-package fzf
  :general
  (general-def
    :prefix "<leader> z"
    :prefix-command 'Fzf
    "f" '("Fzf file" . fzf-find-file)
    "d" '("Fzf file in dir" . fzf-find-file-in-dir)
    )
  ;; :bind
  ;; Don't forget to set keybinds!
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15))
