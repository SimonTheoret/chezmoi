;; -*- lexical-binding: t -*-



;; Makes emacs good looking

;; Smooth scrolling
;; (use-package smooth-scrolling
;;   :init
;;   (smooth-scrolling-mode 1))
;; (defun frame-transparency ()
;;   (interactive)
;;   (set-frame-parameter nil 'alpha-background 70)
;;   (add-to-list 'default-frame-alist '(alpha-background . 70))
;;   )

;; (if (string= "gnu/linux" system-type)
;; 	(frame-transparency)
;;  )
;; Theme
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-molokai-sick t))

  ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  ;; (doom-themes-org-config))

;; (use-package all-the-icons
;;   :if (display-graphic-p))


;;   :init
;;   (all-the-icons-completion-mode)
;;   (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

(use-package all-the-icons
  :if (display-graphic-p))
;; (use-package all-the-icons-dired
;;   :after all-the-icons
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package nerd-icons)
(use-package nerd-icons-dired
  :init
  (nerd-icons-dired-mode))
;; :hook
;; (dired-mode . nerd-icons-dired-mode))

;; The essential modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

;; use-package with package.el:
(use-package dashboard
  :ensure t
  :init
  (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner (concat user-emacs-directory "true.png"))
  (setq dashboard-center-content t)
  )

;; Noice splash screen
;; (use-package dashboard
;;   :after (nerd-icons org)
;;   :init
;;   (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*") ;; does not collide with magit
;; 				(dashboard-mode)
;; 				(dashboard-insert-startupify-lists)
;; 				(dashboard-refresh-buffer)))
;;   (setq dashboard-display-icons-p t) ;; display icons on both GUI and terminal
;;   (setq dashboard-icon-type 'nerd-icons) ;; use `nerd-icons' package
;;   (setq dashboard-center-content t)
;;   :config
;;   (dashboard-setup-startup-hook)
;;   (dashboard-refresh-buffer)
;;   )

;; cute aestethic plugin
;; (use-package solaire-mode
;;   :init
;;   (solaire-global-mode +1))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))


(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode '("--" "---" "==" "===" "!=" "!==" "=!="
				       "=:=" "=/=" "<=" ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!"
				       "??" "???" "?:" "?." "?=" "<:" ":<" ":>" ">:" "<:<" "<>" "<<<" ">>>"
				       "<<" ">>" "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##" "###" "####"
				       "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#=" "^=" "<$>" "<$"
				       "$>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</" "</>" "/>" "<!--" "<#--"
				       "-->" "->" "->>" "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>"
				       "==>" "=>" "=>>" ">=>" ">>=" ">>-" ">-" "-<" "-<<" ">->" "<-<" "<-|"
				       "<=|" "|=>" "|->" "<->" "<~~" "<~" "<~>" "~~" "~~>" "~>" "~-" "-~"
				       "~@" "[||]" "|]" "[|" "|}" "{|" "[<" ">]" "|>" "<|" "||>" "<||"
				       "|||>" "<|||" "<|>" "..." ".." ".=" "..<" ".?" "::" ":::" ":=" "::="
				       ":?" ":?>" "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__" "???"
				       "<:<" ";;;"))
  (global-ligature-mode t))
