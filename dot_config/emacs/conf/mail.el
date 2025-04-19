;; -*- lexical-binding: t -*-
(setq mu4e-location "/run/current-system/sw/share/emacs/site-lisp/elpa/mu4e-1.12.7")

(use-package mu4e
  :straight
  (:local-repo mu4e-location
	       :type built-in)
  :if (string= (system-name) "nixos")
  :commands (mu4e)
  :defer t
  :general 
  (general-def
    :states 'normal
    :prefix "<leader> u"
    :prefix-command 'Mail
    "u" '("Mu4e" . mu4e)
    )
  :config
  (setq sendmail-program (executable-find "msmtp")
	send-mail-function #'smtpmail-send-it
	message-sendmail-f-is-evil t
	message-sendmail-extra-arguments '("--read-envelope-from")
	message-send-mail-function #'message-send-mail-with-sendmail
	mu4e-maildir "~/maildir/"
	)
  )
