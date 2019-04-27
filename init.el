;; * Modules
(doom! :completion
       (company +auto)
       ivy

       :ui
       workspaces
       doom
       doom-dashboard
       modeline
       hl-todo
       nav-flash
       ophints
       window-select
       :editor
(evil
        +everywhere)
              file-templates
              snippets
       rotate-text
       :emacs
       vc
       dired
       electric
       imenu

       :tools
(lookup
        +devdocs
        )

       eval
       editorconfig
       gist
       ;flyspell
       ;flycheck
       magit
       reference
       :lang
       python
       (org
        +attach
        +babel
        +capture
        +present)
       (org-private
        +todo
        +babel
        +capture
        +export
        +style)
       emacs-lisp
       markdown
       sh

       :app
       (write
        +wordnut
        +synosaurus)

       :config
       (default +snippets +bindings +commands))

;; * UI
(setq browse-url-browser-function 'xwidget-webkit-browse-url
      display-line-numbers-type nil
;      doom-big-font (font-spec :family "Iosevka" :size 18)
;      doom-font (font-spec :family "Iosevka" :size 14)
;      doom-theme 'doom-nord
;      doom-unicode-font (font-spec :family "Sarasa Mono SC" :size 14)
;      doom-variable-pitch-font (font-spec :family "SF Compact Display" :size 14)
      frame-alpha-lower-limit 0
      frame-title-format
      '("emacs%@"
        (:eval (system-name)) ": "
        (:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name)) "%b")))
      indicate-buffer-boundaries nil
      indicate-empty-lines nil
      org-bullets-bullet-list '("◉")
      pdf-view-use-unicode-ligther nil
      which-key-idle-delay 0.3)

(setq-default fringe-indicator-alist
              (delq (assq 'truncation fringe-indicator-alist)
                    (delq (assq 'continuation fringe-indicator-alist)
                          fringe-indicator-alist)))

;; * Config
(setq +file-templates-dir "~/.doom.d/templates"
      max-specpdl-size 10000
      user-full-name "Alexander Fu Xi"
      user-mail-address "fuxialexander@gmail.com")

;; * Keys
(setq
 doom-localleader-key ","
 +default-repeat-forward-key ";"
 +default-repeat-backward-key "'"
 evil-want-C-u-scroll t
 evil-want-integration t
 evil-shift-width 2
 evil-snipe-override-evil-repeat-keys nil
 evil-collection-company-use-tng nil
 evil-respect-visual-line-mode t
 +magit-hub-features t
 +evil-collection-disabled-list '(elfeed notmuch kotlin-mode simple dired helm ivy anaconda-mode outline))

;; * Hacks
(def-package-hook! ivy-rich
  :pre-init nil
  :pre-config nil)

