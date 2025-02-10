;; -*- lexical-binding: t -*-


(use-package obsidian
  :defer 3
  :config
  (obsidian-specify-path "~/org")
  (global-obsidian-mode t)
  :custom
  ;; This directory will be used for `obsidian-capture' if set.
  (obsidian-inbox-directory "pile")
  ;; Create missing files in inbox? - when clicking on a wiki link
  ;; t: in inbox, nil: next to the file with the link
  ;; default: t
					;(obsidian-wiki-link-create-file-in-inbox nil)
  ;; The directory for daily notes (file name is YYYY-MM-DD.md)
  (obsidian-daily-notes-directory "daily")
  ;; Directory of note templates, unset (nil) by default
					;(obsidian-templates-directory "Templates")
  ;; Daily Note template name - requires a template directory. Default: Daily Note Template.md
					;(obsidian-daily-note-template "Daily Note Template.md")
  :general
  (general-def
    :states 'normal
    :prefix "<leader> n" ;; This prefix definition must be placed AFTER the definition of the Org prefix
    :prefix-command 'Obsidian
    ;; Replace C-c C-o with Obsidian.el's implementation. It's ok to use another key binding.
    "g" '("Follow thing" . obsidian-follow-link-at-point)
    ;; Jump to backlinks
    "b" '("Follow backlink" . obsidian-backlink-jump)
    ;; If you prefer you can use `obsidian-insert-link'
    "i" '("Insert link" . obsidian-insert-link)
    "t" '("Daily note" . obsidian-daily-note)
    "j" '("Obsidian jump" . obsidian-jump)
    "s" '("Regex notes" . obsidian-search)
    "c" '("Capture note" . obsidian-capture)
    "f" '("Search dir" . search-org-dir)
    "u" '("Update obsidian.el" . obsidian-update)
    "y" '("Yesterday daily" . obsidian-yesterday-file)
    "n" '("Tomorrow daily" . obsidian-tomorrow-file)
    )
  )

(defun search-org-dir ()
  (interactive)
  (ido-find-file-in-dir "~/org" ))


(defun yesterday-yyyy-mm-dd-string ()
  "Returns back yesterday date in the `yyyy-mm-dd` format, as a string"
  (interactive)

  (message "%s" (format-time-string "%Y-%m-%d"  (encode-time (decoded-time-add (decode-time) (make-decoded-time :day -1 )))))
  )

(defun tomorrow-yyyy-mm-dd-string ()
  "Returns back tomorrow date in the `yyyy-mm-dd` format, as a string"
  (interactive)
  (message "%s" (format-time-string "%Y-%m-%d"  (encode-time (decoded-time-add (decode-time) (make-decoded-time :day 1 )))))
  )

(defun obsidian-tomorrow-file ()
  (interactive)
  (find-file (concat "~/org/daily/"  
		     (tomorrow-yyyy-mm-dd-string)
		     ".md"
		     )
	     )
  )

(defun obsidian-yesterday-file ()
  (interactive)
  (find-file (concat "~/org/daily/"  
		     (yesterday-yyyy-mm-dd-string)
		     ".md"
		     )
	     )
  )
