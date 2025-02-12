;; -*- lexical-binding: t -*-


(use-package helpful
  :general
  ("C-h f"   '("callable help" . helpful-callable)
   "C-h v"   '("variable help" . helpful-variable)
   "C-h k"   '("key help" . helpful-key)
   "C-h x"   '("command help" . helpful-command)
   "C-c C-d" '("help at point" . helpful-at-point)
   "C-h F"   '("help function" . helpful-function)
   )
  )


(use-package casual)

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


(defun get-buffer-mode ()
  "Returns the major mode associated with the current buffer."
  (interactive)
  (message "%s" major-mode))

