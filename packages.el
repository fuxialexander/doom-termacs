;; -*- no-byte-compile: t; -*-
;;; packages.el

;; * Disable
(package! dired-k :disable t)
(package! flycheck-popup-tip :disable t)
(package! flycheck-pos-tip :disable t)
(package! ob-mongo :disable t)
(package! ob-sql-mode :disable t)
(package! ob-translate :disable t)
(package! xclip :disable t)
;; * UI
(package! prettify-utils :recipe (:fetcher github :repo "Ilazki/prettify-utils.el" :files ("*")))
(package! shr-tag-pre-highlight)
;; * Tools
(package! orgit)
(package! org-kanban)
(package! alert)


;; * Writing
(package! academic-phrases)
;; * Coding
(package! ivy-yasnippet)
(package! helpful)
(package! tldr)
(package! electric-operator)
(package! emacs-snippets :recipe (:fetcher github :repo "hlissner/emacs-snippets" :files ("*")))
(package! lispy)
(package! lispyville)
(package! sed-mode)
(package! function-args)
(package! snakemake-mode)
(package! deadgrep)
