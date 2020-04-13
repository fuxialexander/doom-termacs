;; * Modules
(doom! :completion
       (company +auto)
       ivy

       :ui
       (popup +all +defaults)
       vc-gutter
       doom
       doom-dashboard
       hl-todo
       hydra
       modeline
       ophints
       treemacs
       window-select
       workspaces
       zen

       :editor
       (evil +commands +everywhere)
       file-templates
       fold
       (format +onsave)
       lispy
       multiple-cursors
       rotate-text
       snippets
       word-wrap

       :emacs
       dired
       dired-plugins
       electric
       ibuffer
       vc

       :tools
       (eval +overlay)
       magit

       :lang
       (org
        +dragndrop
        +pomodoro)
       org-private
       emacs-lisp
       markdown
       sh

       :config
       (default +snippets +bindings +commands))

;; * UI
(setq browse-url-browser-function 'xwidget-webkit-browse-url
      display-line-numbers-type nil
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
(setq
 max-specpdl-size 10000
 user-full-name "Alexander Fu Xi"
 user-mail-address "fuxialexander@gmail.com")

;; * Keys
(setq
 doom-localleader-key ","
 evil-want-C-u-scroll t
 evil-want-integration t
 evil-shift-width 2
 evil-snipe-override-evil-repeat-keys nil
 evil-respect-visual-line-mode t
 +evil-collection-disabled-list '(elfeed notmuch kotlin-mode simple dired helm ivy anaconda-mode outline))
