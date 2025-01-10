;; -*- lexical-binding: t -*- 

(use-package
  exec-path-from-shell
  :defer 1
  :init
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  (when (daemonp)
    (exec-path-from-shell-initialize)))

