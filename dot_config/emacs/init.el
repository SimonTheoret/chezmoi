;; -*- lexical-binding: t -*-
(setq gc-cons-threshold (* 1024 1024 100)) ; 100 MiB
(setq use-package-compute-statistics t)
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
;;loading function
(defun config-load-file-no-extension (content)
  "Loads and runs the file contained in the directory user-emacs-directory/conf"
  (let ((path (concat user-emacs-directory "conf/" content)))
    (load(locate-user-emacs-file path))))

;; Immediate loading
(add-to-list 'load-path (concat user-emacs-directory "conf/"))
;;--------- Does not require packages.el -----------;;
(config-load-file-no-extension "generic")

(load (locate-user-emacs-file "packages.el"))

(setq org-agenda-skip-unavailable-files t)

;; Avoids bunch of warnings when loading or compiling
(setq warning-minimum-level :error)

;;--------- Does require packages.el -----------;;
(config-load-file-no-extension "keybindings")
(config-load-file-no-extension "looks")
(config-load-file-no-extension "completion")
(config-load-file-no-extension "diredup")
(config-load-file-no-extension "search")
(config-load-file-no-extension "lsp")
(config-load-file-no-extension "dap")
(config-load-file-no-extension "treesitter")
(config-load-file-no-extension "emacslisp")
(config-load-file-no-extension "views")
(config-load-file-no-extension "projectsman")
(config-load-file-no-extension "git")
(config-load-file-no-extension "buffers")
(config-load-file-no-extension "help")
(config-load-file-no-extension "pdf")
(config-load-file-no-extension "hooks")
(config-load-file-no-extension "undo")
(config-load-file-no-extension "terminal")
(config-load-file-no-extension "check")
(config-load-file-no-extension "latexlang")
(config-load-file-no-extension "shellenv")
(config-load-file-no-extension "format")
(config-load-file-no-extension "utils")
(config-load-file-no-extension "compi")
(config-load-file-no-extension "spelling")
(config-load-file-no-extension "envir")
(config-load-file-no-extension "file_types")
(config-load-file-no-extension "feed")
(config-load-file-no-extension "mail")
(config-load-file-no-extension "conf_end")
(config-load-file-no-extension "pythonmode")
(config-load-file-no-extension "rustmode")
(config-load-file-no-extension "gomode")
(config-load-file-no-extension "notes")
;; (config-load-file-no-extension "obsid")
