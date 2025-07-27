;; -*- lexical-binding: t -*-


(setq ispell-dictionary "english")
(setq ispell-silently-savep t)

(general-def
  :states 'normal
  :prefix "<localleader> s"
  :prefix-command 'Spelling
  "i" '("Spelling in current buffer" . ispell)
  "s" '("Switch dict" . ispell-change-dictionary)
  )
