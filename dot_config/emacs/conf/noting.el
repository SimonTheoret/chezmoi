;; -*- lexical-binding: t -*-

;; ;;;;;;;;; org-mode ;;;;;;;;


(defun org--set-latex-scale ()
  (plist-put org-format-latex-options :scale 1.5)
  (message "Setting latex preview options completed"))

(setq
 ;; Edit settings
 org-return-follows-link t
 org-auto-align-tags nil
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t
 ;; ;;org-ellipsis "…"
 org-ellipsis " "

 ;; Agenda styling
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ "
   "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string "◀── now ─────────────────────────────────────────────────"
 org-cycle-hide-block-startup t
 org-startup-folded t
 org-startup-indented t
 org-agenda-files '("~/org/agenda/agenda.org")
 org-directory '("~/org/agenda"))

;; Pretty indenting
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook #'org--set-latex-scale)


;; (add-hook 'org-mode-hook  #'rust-org-src-lang)

;; (defun rust-org-src-lang ()
;;   (add-to-list 'org-src-lang-modes '("rust" . rustic) )
;;   )

;; (use-package org-modern
;;   :after org)

;; (add-hook 'org-mode-hook #'org-modern-mode)
;; (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)


(general-def
  :states
  'normal
  :prefix "<leader> n"
  :prefix-command 'Notes
  "c"
  '("Org capture" . org-roam-capture))

(general-def
  :states
  'normal
  :prefix "<leader> n a"
  :prefix-command 'Agenda
  "a"
  '("Org agenda" . org-agenda)
  "f"
  '("Org agenda file" . org-cycle-agenda-files))

;; org roam v2
(use-package org-roam
  :custom (org-roam-directory  "~/org/roam")
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
         "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol)
  (setq org-roam-dailies-directory "org/daily")
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


(use-package org-contrib)

(use-package consult-org-roam
  :after org-roam
  :custom
  ;; Use `ripgrep' for searching with `consult-org-roam-search'
  (consult-org-roam-grep-func #'consult-ripgrep))

(defun test-if-line-starts-with-char (char)
  "Tests if the line under the pointer starts with a char (string)
  character. If so, this function returns t. Else, it returns nil."
  (let* (
	 (myLine
	  (buffer-substring-no-properties
	   (line-beginning-position)
	   (line-end-position)))
	 (firstChar (substring myLine 0 ( + (-(length myLine)) 1)))
	 )
    (if (string-equal firstChar char)
	't
      nil)
    ))

(defun demote-heading-or-evil-default ()
  (interactive)
  (if (test-if-line-starts-with-char "*")
      (org-demote-subtree)
    (evil-shift-left-line 1)))

(defun promote-heading-or-evil-default ()
  (interactive)
  (if (test-if-line-starts-with-char "*")
      (org-promote-subtree)
    (evil-shift-right-line 1)))


(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> c"
  :prefix-command 'Ctrl-c
  "c"
  '("Org ctrl-c" . org-ctrl-c-ctrl-c))

(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> m"
  :prefix-command 'Math
  "p"
  '("Org preview latex" . org-latex-preview))

(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> n"
  :prefix-command 'Node
  "n"
  '("New node" . org-id-get-create))

(general-def
  :states 'normal
  :keymaps '(org-mode-map mu4e-headers-mode-map)
  :prefix "<localleader> l"
  :prefix-command 'Link
  "s"
  '("Org store link" . org-store-link)
  "i"
  '("Org insert link" . org-insert-link))

(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> a"
  :prefix-command 'Archive
  "d"
  '("Archive subtree" . org-archive-subtree-default))

(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> i"
  :prefix-command 'Insert
  "c"
  '("Insert heading/checkbox" . org-insert-todo-heading)
  "h"
  '("Insert heading" . org-insert-heading))

(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> t"
  :prefix-command 'Toggling
  "c"
  '("Toggle checkbox" . org-toggle-checkbox)
  "h"
  '("Toggle heading" . org-toggle-heading)
  "i"
  '("Toggle item" . org-toggle-item)
  "t"
  '("Toggle todo" . org-todo))


(general-def
  :states 'normal
  :keymaps 'org-mode-map
  "<return>"
  '("Follow link" . org-open-at-point))


(general-def
  :states 'insert
  :keymaps 'org-mode-map
  "C-d"
  '("Promote or move left" . (lambda () (interactive) (promote-heading-or-evil-default)))
  "C-t"
  '("Demote or move right" . (lambda () (interactive) (demote-heading-or-evil-default)))
  )

;; Org capture templates
(setq
 org-roam-capture-templates
 '(
  ("d" "default" plain "%?" :target
   (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title} ")
   :unnarrowed t)
  ("a" "article" plain "%? " :target
   (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n* Article ${title}\n[[%^{Article Link}][Original Article]]\n** Related articles:\n- \n** Follow up articles:\n- \n** Abstract\n** Key Points\n*** ")
   :unnarrowed t)
  ("s" "subject" plain "%? " :target
   (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n* ${title}\n- [[%^{Reference}][Reference]]\n** Related notes:\n- \n** Key points\n- ")
   :unnarrowed t)

  )
)

;;  '(("r" "Évènements récurrents" plain
;;     (file+headline
;;      "~/org/agenda/agenda.org" "Évènements récurrents")
;;     "** %?%(org-insert-time-stamp nil nil nil nil nil \" +1w\")")

;;    ("u" "Évènements uniques" plain
;;     (file+headline
;;      "~/org/agenda/agenda.org" "Évènements uniques")
;;     "** %?%^T")

;;    ("t"
;;     "Tâches uniques"
;;     plain
;;     (file+headline "~/org/agenda/agenda.org" "Tâches uniques")
;;     "** TODO %? DEADLINE: %^T")
;;    ("g"
;;     "Tâches récurrentes"
;;     plain
;;     (file+headline "~/org/agenda/agenda.org" "Tâches récurrentes")
;;     "** TODO %? DEADLINE: %(org-insert-time-stamp nil nil nil nil nil \" +1w\")")

;;    ("e"
;;     "École"
;;     plain
;;     (file+headline "~/org/agenda/agenda.org" "École")
;;     "** TODO %? DEADLINE: %^t :école:")

;;    ("i"
;;     "Inbox"
;;     plain
;;     (file+headline "~/org/todo.org" "Inbox")
;;     "** TODO %?")

;;    ("c" "Tâche contextuelles" plain
;;     (file+headline
;;      "~/org/agenda/agenda.org" "Tâches contextuelles")
;;     "** %?")

;;    ("a" "Tâches en attentes" plain
;;     (file+headline
;;      "~/org/agenda/agenda.org" "Tâches en attentes")
;;     "** %?")

;;    ("p"
;;     "Projets"
;;     plain
;;     (file+headline "~/org/agenda/agenda.org" "Projets")
;;     "** %?")))
;; (use-package obsidian
;;   :config
;;   (obsidian-specify-path "~/org")
;;   (global-obsidian-mode t)
;;   :custom
;;   ;; This directory will be used for `obsidian-capture' if set.
;;   (obsidian-inbox-directory nil)
;;   ;; Create missing files in inbox? - when clicking on a wiki link
;;   ;; t: in inbox, nil: next to the file with the link
;;   ;; default: t
;; 					;(obsidian-wiki-link-create-file-in-inbox nil)
;;   ;; The directory for daily notes (file name is YYYY-MM-DD.md)
;;   (obsidian-daily-notes-directory "daily")
;;   ;; Directory of note templates, unset (nil) by default
;; 					;(obsidian-templates-directory "Templates")
;;   ;; Daily Note template name - requires a template directory. Default: Daily Note Template.md
;; 					;(obsidian-daily-note-template "Daily Note Template.md")
;;   :general
;;   (general-def
;;     :states 'normal
;;     :prefix "<leader> n" ;; This prefix definition must be placed AFTER the definition of the Org prefix
;;     :prefix-command 'Obsidian
;;     ;; Replace C-c C-o with Obsidian.el's implementation. It's ok to use another key binding.
;;     "g" '("Follow thing" . obsidian-follow-link-at-point)
;;     ;; Jump to backlinks
;;     "b" '("Follow backlink" . obsidian-backlink-jump)
;;     ;; If you prefer you can use `obsidian-insert-link'
;;     "i" '("Insert link" . obsidian-insert-link)
;;     "t" '("Daily note" . obsidian-daily-note)
;;     "j" '("Obsidian jump" . obsidian-jump)
;;     "s" '("Search notes" . obsidian-search)
;;     "c" '("Captur note" . obsidian-capture)
;;     ;; TODO: Add kb for toggling and inserting checkboxes, smart adding `-` and checkboxes
;;     )
;;   )
