;; -*- lexical-binding: t -*-

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
	)
      )

(defun install-treesit-langs ()
  "Installs all the Treesitter parsers for the languages in `treesit-language-source-alist`"
  (interactive)
  (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
  )


(use-package treesit-auto
  ;;  :defer 1
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  )

(add-hook 'prog-mode-hook (lambda ()
			    (treesit-font-lock-recompute-features '(function custom))))

