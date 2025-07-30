;; -*- lexical-binding: t -*-

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-vc-git-default-clone-depth '(1 single-branch))  ;; instead of the default 'full
(setq use-package-verbose t)

(setq native-comp-async-report-warnings-errors 'silent)

(use-package straight
  :custom
  (straight-use-package-by-default t))

(use-package general
  :config
  (general-evil-setup t))

(use-package
  evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-overrifing-maps nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-minibuffer t)
  :config (evil-mode 1)

  (evil-set-leader
   '(normal visual replace operator motion emacs)
   (kbd "SPC")) ;; leader declaration
  (evil-set-leader 'normal (kbd "SPC m") t) ;; Local leader declaration
  :bind (
	 :map evil-insert-state-map
	 ("<down-mouse-1>" . nil)
	 ("<mouse-1>" . nil)
	 ("<down-mouse-3>" . nil)
	 ("<mouse-3>" . nil)
	 ("C-a" . nil)
	 ("C-e" . nil)
	 :map evil-normal-state-map
	 ("<down-mouse-1>" . nil)
	 ("<mouse-1>" . nil)
	 ("<down-mouse-3>" . nil)
	 ("<mouse-3>" . nil)
	 :map    evil-motion-state-map
	 ("<down-mouse-1>" . nil)
	 ("<mouse-1>" . nil)
	 ("<down-mouse-3>" . nil)
	 ("<mouse-3>" . nil)
	 ))

;; TODO: Use this package ?
(use-package apheleia
  :defer 1
  :config
  (setf (alist-get 'python-mode apheleia-mode-alist)
	'(ruff))
  (setf (alist-get 'python-ts-mode apheleia-mode-alist)
	'(ruff))
  :hook
  (python-ts-mode . apheleia-mode)
  (rustic-mode . apheleia-mode)
  (emacs-lisp-mode . apheleia-mode)
  )



(use-package eglot
  :defer 0.5
  :straight (:type built-in)
  :hook (prog-mode . eglot-ensure))

(setq-default eglot-inlay-hints-mode nil)
(setq-default eldoc-idle-delay 0.15)

(use-package eglot-booster
  :defer 0.25
  :straight ( eglot-booster :type git :host nil :repo "https://github.com/jdtsmith/eglot-booster")
  :after eglot
  :config (eglot-booster-mode))

(use-package company
  :defer 0.5
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0.100)
  (setq company-backends '((company-capf  company-files company-keywords :with company-yasnippet)))
  :general-config
  (general-def company-active-map
    "<backtab>" (lambda () (interactive) (company-complete-common-or-cycle -1))
    "S-TAB" (lambda () (interactive) (company-complete-common-or-cycle -1))
    "TAB" #'company-complete-common-or-cycle
    "<tab>" #'company-complete-common-or-cycle
    "RET" #'newline
    "<return>" #'newline
    "C-<return>" #'company-complete-selection
    "C-<RET>" #'company-complete-selection
    "C-b" #'company-complete-selection
    "C-w" #'evil-delete-backward-word
    )
  :general
  (general-def
    :states 'insert
    "C-x C-f" '("Complete files". company-files)
    )
  )


(use-package
  exec-path-from-shell
  :defer 1
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  (when (daemonp)
    (exec-path-from-shell-initialize)))

(use-package org
  :defer 1
  :straight (:type built-in))
;; org roam v2
(use-package org-roam
  :custom (org-roam-directory  "~/org/roam")
  :after org
  :general
  (general-def
    :states 'normal
    :prefix "<leader> n r" ;; This prefix definition must be placed AFTER the definition of the Org prefix
    :prefix-command 'Roam
    "l"
    '("Roam buffer toggle" . org-roam-buffer-toggle)
    "f"
    '("Roam find node" . org-roam-node-find)
    "g"
    '("Roam graph" . org-roam-graph)
    "i"
    '("Roam insert node " . org-roam-node-insert)
    "c"
    '("Roam capture" . org-roam-capture)
    "c"
    '("Dailies capture today" . org-roam-dailies-capture-today)
    "t"
    '("Today dailies" . org-roam-dailies-goto-today)
    "y"
    '("Yesterday dailies" . org-roam-dailies-goto-yesterday)
    "s"
    '("Search roam dir" . consult-org-roam-search)
    )
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template
	(concat
         "${title:*} " (propertize "${tags:10}" 'face 'orgomtag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol)
  (setq org-roam-dailies-directory "daily")
  (setq org-roam-completion-everywhere t)
  (cl-defmethod org-roam-node-hierarchy ((node org-roam-node))
    (let ((level (org-roam-node-level node)))
      (concat
       (when (> level 0) (concat (org-roam-node-file-title node) " > "))
       (when (> level 1) (concat (string-join (org-roam-node-olp node) " > ") " > "))
       (org-roam-node-title node))))

  (setq org-roam-node-display-template "${hierarchy:*} ${tags:20}")
  (setq
   org-roam-dailies-capture-templates
   '(("d"
      "default"
      entry
      "* %?"
      :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n")))))


;; (use-package kanagawa-themes
;;   :ensure t
;;   :config
;;   (load-theme 'kanagawa-wave t))

(use-package gruvbox-theme
  :config
  (setq gruvbox-bold-constructs t)
  (load-theme 'gruvbox-dark-medium t)) ;; We need to add t to trust this package

(add-to-list 'default-frame-alist '(alpha-background . 90)) ;; For all new frames henceforth

;; ;; Theme
;; (use-package doom-themes
;;   :straight (doom-themes
;; 	     :type git
;; 	     :host github
;; 	     :repo "doomemacs/themes"
;; 	     :commit "3c03f525d5c0ac0859f31231778f97e10a705e0d")
;;   :config
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-molokai-sick t)
;;   )

(use-package nerd-icons)
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; The essential modeline
(use-package doom-modeline
  :custom  (doom-modeline-height 25) ;; Set modeline height
  :hook (after-init . doom-modeline-mode))


(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(setq completions-format 'one-column)
(setq completions-header-format nil)
(setq completions-max-height 20)
(setq completion-auto-select nil)

(define-key minibuffer-mode-map (kbd "C-n") 'minibuffer-next-completion)
(define-key minibuffer-mode-map (kbd "C-p") 'minibuffer-previous-completion)
(define-key completion-in-region-mode-map (kbd "C-n") 'minibuffer-next-completion)
(define-key completion-in-region-mode-map (kbd "C-p") 'minibuffer-previous-completion)

(general-def
  :states 'normal
  :prefix "<leader> b"
  :prefix-command 'Buffers
  "i" '("Ibuffer" . ibuffer)
  "L" '("Buffer project list" . project-switch-to-buffer)
  "l" '("Buffer list" . switch-to-buffer)
  "r" '("Rename buffer" . rename-buffer)
  "f" '("Rename buffer and file" . crux-rename-buffer-and-file)
  "d" '("Delete current buffer" . kill-current-buffer)
  "D" '("Delete current buffer and window" . kill-buffer-and-window)
  "s" '("Scratch buffer" . scratch-buffer)
  "n" '("Ibuffer mark by name" . ibuffer-mark-by-file-name-regexp)
  "b" '("Focus current buffer" . delete-other-windows)
  )


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


(use-package git-timemachine :defer 5)

(use-package git-gutter
  :after magit
  :init
  (global-git-gutter-mode +1) 
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
;; Generic goodies

;; (setq inhibit-startup-message t)

;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Desktop
(if (and  (string= "simon" (user-login-name)) (string= "gnu/linux" system-type) (string= "desktop" (getenv "NIXOS_CONF")))
    (add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font Mono-11")))
;; Laptop
(if (and (string= "simon" (user-login-name)) (string= "gnu/linux" system-type) (string= "laptop" (getenv "NIXOS_CONF")))
    (add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font Mono-13")))
;; Serveur druide
(if (and (string= "stheoret" (system-name)) (string= "gnu/linux" system-type))
    (add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font Mono-11")))
;; MacOS Druide
(if (and (string= "stheoret" (system-name)) (string= "darwin" system-type))
    (add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font Mono-12")))

;; Optimization: https://www.reddit.com/r/emacs/comments/f3ed3r/how_is_doom_emacs_so_damn_fast/
(setq frame-inhibit-implied-resize t)
(setq initial-major-mode 'fundamental-mode)

;; Scrolling
(pixel-scroll-mode 1)
(setq scroll-step 1)
(setq scroll-conservatively 10)

(setq make-backup-files nil) ;; Stop creating ~ backup files
(setq auto-save-default nil)

(setq blink-cursor-mode t)


;; Electric defaults
(electric-pair-mode t)
(electric-indent-mode t)



(setq confirm-kill-emacs #'yes-or-no-p)

;; The variable redisplay-dont-pause, when set to t, will cause Emacs
;; to fully redraw the display before it processes queued input
;; events. This may have slight performance implications if you’re
;; aggressively mouse scrolling a document or rely on your keyboard’s
;; auto repeat feature. For most of us, myself included, it’s probably
;; a no-brainer to switch it on.
(setq redisplay-dont-pause nil)

(add-hook 'text-mode-hook #'auto-fill-mode)



;; Enable vertico
(use-package
  vertico
  :init (vertico-mode)
  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  (setq read-file-name-completion-ignore-case t
	read-buffer-completion-ignore-case t
	completion-ignore-case t)

  (setq completion-styles '(basic substring partial-completion flex))
  (setq vertico-count 15)
  (setq vertico-resize 'grow-only)
  (setq vertico-cycle t)
  :general-config
  (
   :keymaps 'vertico-map
   :states 'insert
   "TAB"
   #'minibuffer-complete
   "RET"
   #'vertico-directory-enter
   "DEL"
   #'vertico-directory-delete-char
   "M-DEL"
   #'vertico-directory-delete-word
   "C-n"
   #'vertico-next
   "C-p"
   #'vertico-previous
   )
  )
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist :init (savehist-mode))

;; A few more useful configurations...
(use-package
  emacs
  :custom
  (global-auto-revert-mode t)
  :init

  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons
     (format "[CRM%s] %s"
             (replace-regexp-in-string
              "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" "" crm-separator)
             (car args))
     (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
	'(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)
  (setq help-window-select t) ; Switch to help buffers automatically

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))




(use-package
  orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles basic partial-completion)))))

(use-package consult :defer 0.5)

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))


(setq async-shell-command-display-buffer nil)

;; Consult users will also want the embark-consult package.

(use-package tldr :defer 1)

(use-package deadgrep :defer 2)

;; TODO: remove ?
;; (eval-when-compile
;;   (require 'cl-lib))

(setq reb-re-syntax 'string)

(general-def
  :states
  'normal
  :prefix "<leader> s"
  :prefix-command 'Search
  "j"
  '("Jump marks" . evil-collection-consult-jump-list)
  "g"
  '("Filter search current dir" . lgrep)
  "d"
  '("Search current dir" . consult-ripgrep)
  "m"
  '("Multi occur" . multi-occur-in-matching-buffers)
  "M"
  '("Multi occur mode" . multi-occur-in-this-mode)
  "o"
  '("Occur" . occur)
  "l"
  '("Search for line" . consult-line-multi)
  "b"
  '("Search in buffer" . consult-line)
  "s"
  '("Search and replace" . query-replace)
  "t"
  '("Search todos in buffers" . consult-todo-all)
  "h"
  '("Hide lines" . consult-focus-lines)
  "r"
  '("Deadgrep" . deadgrep)
  "a"
  '("Locate" . consult-locate)
  "x"
  '("Regex Builder" . re-builder)
  )

(general-def
  :states
  'normal
  :prefix "<leader> h"
  :prefix-command 'Help
  "t"
  '("Tldr command" . tldr)
  "w"
  '("Manual with woman" . woman)
  "m"
  '("Manual with man" . man)
  )

;; Pdf tools
(use-package pdf-tools
  :defer 3
  :init (setq pdf-view-use-unicode-ligther nil)
  :config
  (pdf-tools-install)
  (setq auto-revert-interval 0.5)
  )


(use-package hl-todo
  :defer 0.5
  :init
  (global-hl-todo-mode))

(use-package vterm
  :defer 1.5
  :config
  (setq-default vterm-kill-buffer-on-exit t)
  (setq vterm-timer-delay 0.01)
  )

(add-hook 'evil-insert-state-entry-hook #'vterm-reset-cursor-point nil t)


(tab-bar-mode)
(general-def
  :states 'normal
  :prefix "<leader> t"
  :prefix-command 'Term
  "t" '("Toggle eshell" . eshell)
  "b" '("Open terminal" . term)
  "a" '("Open ansi-term" . ansi-term)
  "v" '("Open vterm" . vterm)
  "o"
  '("New tab" . tab-new)
  "x"
  '("Close tab" . tab-close))


(general-def
  :states 'normal
  "L"
  '("Next tab" . tab-next)
  "H"
  '("Previous tab" . tab-previous)
  )

(use-package web-mode :defer 1)

(use-package rust-mode
  :defer 1
  :init
  (setq rust-mode-treesitter-derive t)
  )


(setq dired-listing-switches "-alh")

(use-package diredfl :config (diredfl-global-mode))

(use-package
  dired-rsync
  :bind (:map dired-mode-map ("<leader> r r" . dired-rsync)))

(use-package
  dired-rsync-transient
  :bind
  (:map dired-mode-map ("<leader> r t" . dired-rsync-transient)))


(use-package async
  :init
  (dired-async-mode 1))

(use-package ido)

(defun search-nixdots ()
  (interactive)
  (ido-find-file-in-dir "~/nixdots/" ))

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
  "F"
  '("Find files other window" . ido-find-file-other-window)
  "p"
  '("Search conf" . search-emacs-dir)
  "P"
  '("Search conf other window" . search-emacs-dir-other-window)
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
  "O"
  '("Dired here other window" . dired-jump-other-window)
  "l"
  '("Chezmoi files" . search-chezmoi-dir)
  "L"
  '("Chezmoi files other window" . search-chezmoi-dir-other-window)
  "u"
  '("Nixdots files" . search-nixdots)
  "U"
  '("Nixdots files other window" . search-nixdots-other-window)
  "h"
  '("Home files" . search-home-dir)
  "H"
  '("Home files other window" . search-home-dir-other-window)
  "a"
  '("Find file at point" . find-file-at-point)
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


(general-def
  :states 'normal
  :map dired-mode-map
  "DEL" '("Directory up" . dired-up-directory)
  )

;; TODO: setup
;; Used for eglot
;; (use-package dape
;;   :defer 3
;;   ;; :preface
;;   ;; By default dape shares the same keybinding prefix as `gud'
;;   ;; If you do not want to use any prefix, set it to nil.
;;   ;; (setq dape-key-prefix "\C-x\C-a")

;;   ;; :hook
;;   ;; Save breakpoints on quit
;;   ;; (kill-emacs . dape-breakpoint-save)
;;   ;; Load breakpoints on startup
;;   ;; (after-init . dape-breakpoint-load)

;;   ;; :config
;;   ;; Turn on global bindings for setting breakpoints with mouse
;;   ;; (dape-breakpoint-global-mode)

;;   ;; Info buffers to the right
;;   ;; (setq dape-buffer-window-arrangement 'right)

;;   ;; Info buffers like gud (gdb-mi)
;;   ;; (setq dape-buffer-window-arrangement 'gud)
;;   ;; (setq dape-info-hide-mode-line nil)

;;   ;; Pulse source line (performance hit)
;;   ;; (add-hook 'dape-display-source-hook 'pulse-momentary-highlight-one-line)

;;   ;; Showing inlay hints
;;   ;; (setq dape-inlay-hints t)

;;   ;; Save buffers on startup, useful for interpreted languages
;;   ;; (add-hook 'dape-start-hook (lambda () (save-some-buffers t t)))

;;   ;; Kill compile buffer on build success
;;   ;; (add-hook 'dape-compile-hook 'kill-buffer)

;;   ;; Projectile users
;;   ;; (setq dape-cwd-function 'project-root)
;;   )



(use-package helpful
  :defer 1.5
  :general
  ("C-h f"   '("callable help" . helpful-callable)
   "C-h v"   '("variable help" . helpful-variable)
   "C-h k"   '("key help" . helpful-key)
   "C-h x"   '("command help" . helpful-command)
   "C-c C-d" '("help at point" . helpful-at-point)
   "C-h F"   '("help function" . helpful-function)
   )
  )


(use-package casual
  :defer 1.5
  )

(general-def
  :states 'normal
  "<leader> a c" '("Calc" . calc)
  )

(general-def
  :states 'normal
  :keymaps 'isearch-mode-map
  "<leader> C-o"
  '("Casual isearch" . casual-isearch-tmenu)
  )

(general-def
  :states 'normal
  :keymaps 'calc-mode-map
  "<leader> C-o"
  '("Casual Calc" . casual-calc-tmenu)
  )

(general-def
  :states 'normal
  :keymaps 'reb-mode-map
  "<leader> C-o"
  '("Casual REbuilder" . casual-re-builder-tmenu)
  )

(general-def
  :states 'normal
  :keymaps 'ibuffer-mode-map
  "<leader> C-o"
  '("Casual ibuffer" . casual-ibuffer-tmenu)
  )

(general-def
  :states 'normal
  :keymaps 'dired-mode-map
  "<leader> C-o"
  '("Casual dired" .  casual-dired-tmenu)
  )


(general-def
  :states 'normal
  "<leader> C-o"
  '("Casual edikit" . casual-editkit-main-tmenu)
  )


;; TOOD: add back ?
;; (use-package python
;;   :straight (:type built-in)
;;   :config
;;   (setq  python--treesit-settings
;; 	 (append python--treesit-settings
;; 		 ;; Constants
;; 		 (treesit-font-lock-rules
;; 		  :feature 'custom
;; 		  :language 'python
;; 		  :override t
;; 		  '(
;; 		    ((identifier) @font-lock-constant-face
;; 		     (:match "^[A-Z][A-Z_0-9]*$" @font-lock-constant-face))
;; 		    )

;; 		  ;; Types 
;; 		  :feature 'custom
;; 		  :language 'python
;; 		  :override t
;; 		  '(
;; 		    (
;; 		     (identifier) @font-lock-type-face
;; 		     (:match "^[A-Z].*[a-z]" @font-lock-type-face))
;; 		    )
;; 		  )
;; 		 )

;; 	 )
;;   )

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
;; 

(defun utils-update-cm-emacs ()
  "Calls `chezmoi apply --force`"
  (interactive)
  (async-shell-command "chezmoi apply --force"))


(use-package crux
  :defer 3
  :general-config
  (general-def
    :states 'normal
    :prefix "<leader> o"
    :prefix-command 'Open
    "e" '("Open current file in external app" . crux-open-with)
    "u" '("View URL content" . crux-view-url)
    "c" '("Chezmoi apply overwrite" . utils-update-cm-emacs)
    ))


(use-package nix-mode
  :defer 1
  :mode "\\.nix\\'")


;; Keybindings


(use-package evil-commentary :config (evil-commentary-mode))

;; evil-collection-setup-minibuffer must be set BEFORE loading evil-collection
(setq-default evil-collection-setup-minibuffer t )
(use-package
  evil-collection
  :after evil
  :init (evil-collection-init) 
  )
(evil-collection-eshell-setup)

(use-package
  evil-surround
  :after evil
  :config (global-evil-surround-mode 1))

(use-package
  evil-args
  :after evil
  :general-config
  (:states
   'normal
   "A-L"
   '("Next arg" . evil-forward-arg)
   "A-H"
   '("previous arg" . evil-backward-arg))
  (:states
   'motion
   "A-L"
   '("Next arg" . evil-forward-arg)
   "A-H"
   '("Previous arg" . evil-backward-arg)))


(use-package evil-easymotion :after evil)


(use-package
  evil-snipe
  :custom (evil-snipe-smart-case t)
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))

;; easy-motion for moving fast af
(use-package evil-easymotion
  :init
  (evilem-default-keybindings "<leader>"))

(use-package
  which-key
  :straight (:type built-in)
  :config (which-key-mode) (setq which-key-idle-delay 0.1))


(use-package evil-mc
  :init
  (global-evil-mc-mode 1))


(use-package ace-window
  :defer 1.5)

(use-package casual-avy
  :defer 1.5)

(general-def
  :states
  'normal
  "<leader> w"
  '("Jump to word" . avy-goto-word-1)
  "<leader> W"
  '("Jump to window" . ace-window)
  "<leader> x"
  '("Swap window" . ace-swap-window)
  "<leader> X"
  '("Delete window" . ace-delete-window)
  )
(general-def
  :states
  'normal
  :prefix "<leader> e"
  :prefix-command 'Eval
  "b"
  '("eval buffer" . eval-buffer)
  )
(general-def
  :states
  'visual
  :prefix "<leader> e"
  :prefix-command 'Eval
  "r"
  '("eval region" . eval-region))

(general-def
  :states
  'normal
  :prefix "<leader> q"
  :prefix-command 'Quit
  "c"
  '("Close frame" . delete-frame)
  "r"
  '("Restart emacs" . restart-emacs)
  "K"
  '("Kill emacs" . save-buffers-kill-emacs)
  )

(general-def
  :states
  'normal
  "TAB"
  '("Jump pairs" . evil-jump-item)
  "m"
  '("Jump pairs" . evil-jump-item)
  )


;; Evil commands (:<yourcommandhere>)
;; :q should kill the current buffer rather than quitting emacs entirely
(evil-ex-define-cmd "q" 'kill-this-buffer)
;; Need to type out :quit to close emacs
(evil-ex-define-cmd "quit" 'evil-quit)

(evil-set-undo-system 'undo-redo)

(with-eval-after-load 'dired
  (evil-collection-define-key 'normal 'dired-mode-map " " nil))
(global-unset-key (kbd "M-SPC") )



(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
 					 (car next-win-edges))
 				     (<= (cadr this-win-edges)
 					 (cadr next-win-edges)))))
             (splitter
 	      (if (= (car this-win-edges)
 		     (car (window-edges (next-window))))
 		  'split-window-horizontally
 		'split-window-vertically)))
 	(delete-other-windows)
 	(let ((first-win (selected-window)))
 	  (funcall splitter)
 	  (if this-win-2nd (other-window 1))
 	  (set-window-buffer (selected-window) this-win-buffer)
 	  (set-window-buffer (next-window) next-win-buffer)
 	  (select-window first-win)
 	  (if this-win-2nd (other-window 1))))))

(evil-global-set-key 'normal (kbd "C-w R") 'toggle-window-split)
(evil-global-set-key 'insert (kbd "C-c p") 'evil-paste-after)
(evil-global-set-key 'insert (kbd "C-c P") 'evil-paste-before)
(evil-global-set-key 'normal (kbd "C-c i") 'next-buffer)
(evil-global-set-key 'normal (kbd "C-c o") 'previous-buffer)

(use-package treesit
  :straight (:type built-in))

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
 	(cmake "https://github.com/uyha/tree-sitter-cmake")
 	(css "https://github.com/tree-sitter/tree-sitter-css")
 	(elisp "https://github.com/Wilfred/tree-sitter-elisp")
 	(go "https://github.com/tree-sitter/tree-sitter-go")
 	(html "https://github.com/tree-sitter/tree-sitter-html")
 	(javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
 	(json "https://github.com/tree-sitter/tree-sitter-json")
 	(make "https://github.com/alemuller/tree-sitter-make")
 	(markdown "https://github.com/ikatyang/tree-sitter-markdown")
 	(python "https://github.com/tree-sitter/tree-sitter-python")
 	(toml "https://github.com/tree-sitter/tree-sitter-toml")
 	(tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
 	(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
 	(yaml "https://github.com/ikatyang/tree-sitter-yaml")
 	(rust "https://github.com/tree-sitter/tree-sitter-rust")
 	(elixir "https://github.com/elixir-lang/tree-sitter-elixir")
 	(gleam "https://github.com/gleam-lang/tree-sitter-gleam")
 	(heex "https://github.com/phoenixframework/tree-sitter-heex")
	(php "https://github.com/tree-sitter/tree-sitter-php" )
 	)
      )

(defun install-treesit-langs ()
  "Installs all the Treesitter parsers for the languages in `treesit-language-source-alist`"
  (interactive)
  (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
  )


(use-package treesit-auto
  :defer 1
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  :hook
  (prog-mode . (lambda ()
 		 (treesit-font-lock-recompute-features '(function custom)))))




(defun change-compile-command (str)
  (set (make-local-variable 'compile-command) str))

(use-package fancy-compilation
  :commands (fancy-compilation-mode))

(with-eval-after-load 'compile
  (fancy-compilation-mode))


(general-def
  :states
  'normal
  :prefix "<leader>"
  "SPC" 
  '("Project find file" . project-find-file)
  )

(general-def
  :states
  'normal
  :prefix "<leader> c"
  "c"
  '("Compile project" . project-compile) ;;TODO: Switcht to project
  "C"
  '("Compile buffer" . compile)
  "r"
  '("Recompile project" . project-recompile)
  "R"
  '("Recompile" . recompile)
  "l"
  '("Kill compilation" . kill-compilation)
  )


(use-package envrc
  :defer 1
  :init
  (envrc-global-mode)
  :general-config
  (general-def :states
    'normal
    "<leader> e e" '("Reload env vars" . envrc-reload)))


(use-package embark
  :defer 1
  :general (general-def ;;:states '('normal 'insert)
	     "S-C-a" '("Embark act". embark-act)         ;; pick some comfortable binding
	     "S-C-e" '("Embark dwim". embark-dwim)        ;; good alternative: M-.
	     "C-h B" '("Embark bindings". embark-bindings)
	     ) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :after '(embar consult)
  :hook


  (embark-collect-mode . consult-preview-at-point-mode))


(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)


