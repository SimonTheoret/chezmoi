(setenv "LSP_USE_PLISTS" "true")
(setq package-enable-at-startup nil)
;; from https://github.com/doomemacs/doomemacs/issues/310
(defvar last-file-name-handler-alist file-name-handler-alist)
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6
      file-fame-handler-alist nil)

(add-hook 'emacs-startup-hook
	  (setq gc-cons-threshold 16777216
		gc-cons-percentage 0.1
		file-name-handler-alist last-file-name-handler-alist))
