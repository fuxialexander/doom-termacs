;;; config.el -*- lexical-binding: t; -*-
;; * config
;; ** general
(setq
 request-storage-directory (concat doom-etc-dir "request/")
 trash-directory "~/.Trash/"
 delete-by-moving-to-trash t
 enable-remote-dir-locals t
 electric-pair-inhibit-predicate 'ignore
 persp-interactive-init-frame-behaviour-override -1
 browse-url-browser-function 'browse-url-default-browser
 org-directory "~/org"
 evil-escape-key-sequence nil
 line-spacing nil
 frame-resize-pixelwise t)

(add-hook! minibuffer-setup (setq-local show-trailing-whitespace nil))
(remove-hook 'text-mode-hook #'hl-line-mode)
(remove-hook 'conf-mode-hook #'hl-line-mode)
;; ** web
(after! eww
  (advice-add 'eww-display-html :around
              'eww-display-html--override-shr-external-rendering-functions))
(after! shr
  (require 'shr-tag-pre-highlight)
  (add-to-list 'shr-external-rendering-functions
               '(pre . shr-tag-pre-highlight)))

;; ** tools
;; *** deadgrep
(def-package! deadgrep
  :commands (deadgrep))
;; *** avy
(after! avy
  (setq avy-keys '(?a ?s ?d ?f ?j ?k ?l ?\;)))
(after! ace-window
  (setq aw-keys '(?f ?d ?s ?r ?e ?w)
        aw-scope 'frame
        aw-ignore-current t
        aw-background nil))
;; *** outline
(def-package! outshine :load-path "~/.doom.d/local/"
  :hook ((outline-minor-mode . outshine-hook-function))
  :config
  (map! :map outline-minor-mode-map
        :nm [tab] #'outline-cycle
        :nm [backtab] #'outshine-cycle-buffer))
(def-package! counsel-oi :load-path "~/.doom.d/local/"
  :after (outshine)
  :commands (counsel-oi))
;; *** magit
;; (def-package! orgit :after (magit org))
;; (after! magithub
;;   (setq magithub-clone-default-directory "~/Repo/"))
;; (after! magit
;;   (defun +magit|remove-fringes ()
;;     (set-window-fringes nil 0 0)
;;     (set-window-margins nil 1 nil))
;;   (add-hook 'magit-post-display-buffer-hook #'+magit|remove-fringes t)
;;   (add-hook! magit-popup-mode-hook #'+magit|remove-fringes)

;;   (after! solaire-mode
;;     (add-hook 'magit-mode-hook #'solaire-mode))
;;   (magit-wip-after-save-mode 1)
;;   (magit-wip-after-apply-mode 1)
;;   (setq magit-save-repository-buffers 'dontask)
;;   (advice-add 'magit-list-repositories :override #'*magit-list-repositories))
;; *** keycast

;; **** ivy-advice
(after! lv
  (advice-add 'lv-window :override #'*lv-window))
(after! colir
  (advice-add 'colir--blend-background :override #'*colir--blend-background)
  (advice-add 'colir-blend-face-background :override #'*colir-blend-face-background))
(after! ivy-hydra
  (defhydra +ivy-coo-hydra (:hint nil :color pink)
    "
 Move     ^^^^^^^^^^ | Call         ^^^^ | Cancel^^ | Options^^ | Action _w_/_s_/_a_: %s(ivy-action-name)
----------^^^^^^^^^^-+--------------^^^^-+-------^^-+--------^^-+---------------------------------
 _g_ ^ ^ _k_ ^ ^ _u_ | _f_orward _o_ccur | _i_nsert | _c_alling: %-7s(if ivy-calling \"on\" \"off\") _C_ase-fold: %-10`ivy-case-fold-search
 ^|^ _h_ ^+^ _l_ ^I^ | _RET_ done     ^^ | _q_uit   | _m_atcher: %-7s(ivy--matcher-desc) _t_runcate: %-11`truncate-lines
 _G_ ^ ^ _j_ ^ ^ _d_ | _TAB_ alt-done ^^ | ^ ^      | _<_/_>_: shrink/grow
"
    ;; arrows
    ("j" ivy-next-line)
    ("k" ivy-previous-line)
    ("l" ivy-alt-done)
    ("h" ivy-backward-delete-char)
    ("g" ivy-beginning-of-buffer)
    ("G" ivy-end-of-buffer)
    ("d" ivy-scroll-up-command)
    ("u" ivy-scroll-down-command)
    ("e" ivy-scroll-down-command)
    ;; actions
    ("q" keyboard-escape-quit :exit t)
    ("C-g" keyboard-escape-quit :exit t)
    ("<escape>" keyboard-escape-quit :exit t)
    ("C-o" nil)
    ("i" nil)
    ("TAB" ivy-alt-done :exit nil)
    ("C-j" ivy-alt-done :exit nil)
    ("RET" ivy-done :exit t)
    ("C-m" ivy-done :exit t)
    ("C-SPC" ivy-call-and-recenter :exit nil)
    ("f" ivy-call)
    ("c" ivy-toggle-calling)
    ("m" ivy-toggle-fuzzy)
    (">" ivy-minibuffer-grow)
    ("<" ivy-minibuffer-shrink)
    ("w" ivy-prev-action)
    ("s" ivy-next-action)
    ("a" ivy-read-action)
    ("t" (setq truncate-lines (not truncate-lines)))
    ("C" ivy-toggle-case-fold)
    ("o" ivy-occur :exit t)))
;; **** ivy-config
(after! ivy
  (setq ivy-use-selectable-prompt t
        ivy-auto-select-single-candidate t
        ivy-rich-parse-remote-buffer nil
        +ivy-buffer-icons nil
        ivy-use-virtual-buffers nil
        ivy-magic-slash-non-match-action 'ivy-magic-slash-non-match-cd-selected
        ivy-height 20
        ivy-rich-switch-buffer-name-max-length 50))
;; **** counsel-config
(after! counsel
  (setq counsel-evil-registers-height 20
        counsel-yank-pop-height 20
        counsel-org-goto-face-style 'org
        counsel-org-headline-display-style 'title
        counsel-org-headline-display-tags t
        counsel-org-headline-display-todo t)
;; **** counsel-load-theme
  ;; reset fringe after change theme
  (advice-add #'counsel-load-theme :after #'solaire-mode-reset)
;; **** ivy-switch-buffer
  (advice-add 'ivy--switch-buffer-action :override #'*ivy--switch-buffer-action)
  (ivy-add-actions
   'ivy-switch-buffer
   '(("d" (lambda (buf) (display-buffer buf)) "display")))
;; **** counsel-M-x
  (ivy-add-actions
   'counsel-M-x
   `(("h" +ivy/helpful-function "Helpful"))))
;; **** counsel-tramp
(def-package! counsel-tramp :load-path "~/.doom.d/local/"
  :commands (counsel-tramp))
;; *** projectile
(after! projectile
  (setq projectile-ignored-projects '("~/" "/tmp")
        projectile-ignored-project-function
        (lambda (root)
          (or (file-remote-p root)
              (string-match ".*Trash.*" root)
              (string-match ".*Cellar.*" root)))))
;; ** emacs
;; *** recentf
(after! recentf
  (setq recentf-auto-cleanup 60)
  (add-to-list 'recentf-exclude 'file-remote-p)
  (add-to-list 'recentf-exclude ".*Cellar.*"))
;; *** comint

;; ** edit
;; *** company

(after! company
  ;; **** prescient
  (def-package! company-prescient
    :hook (company-mode . company-prescient-mode))
  ;; **** company-ui
  (setq company-tooltip-limit 10
        company-tooltip-minimum-width 80
        company-tooltip-minimum 10
        company-backends
        '(company-capf company-dabbrev company-files company-yasnippet)
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)))
;; *** language
;; **** elisp
(after! elisp-mode
  (add-hook 'emacs-lisp-mode-hook #'outline-minor-mode t)
  (remove-hook 'emacs-lisp-mode-hook (lambda
                                      (&rest _)
                                      (set
                                       (make-local-variable 'mode-name)
                                       "Elisp")
                                      (set
                                       (make-local-variable 'outline-regexp)
                                       ";;;;* [^ 	\n]")))
  (setq-hook! 'emacs-lisp-mode-hook mode-name "Elisp")
  (set-lookup-handlers! 'emacs-lisp-mode :documentation #'helpful-at-point))
(after! helpful
  (set-lookup-handlers! 'helpful-mode :documentation #'helpful-at-point))

;; *** yasnippet
(def-package! ivy-yasnippet
  :commands (ivy-yasnippet))
;; *** evil
(after! evil-mc
  ;; Make evil-mc resume its cursors when I switch to insert mode
  (add-hook! 'evil-mc-before-cursors-created
    (add-hook 'evil-insert-state-entry-hook #'evil-mc-resume-cursors nil t))
  (add-hook! 'evil-mc-after-cursors-deleted
    (remove-hook 'evil-insert-state-entry-hook #'evil-mc-resume-cursors t)))
;; *** lispy
(def-package! lispy
  :hook ((emacs-lisp-mode . lispy-mode))
  :init
  (setq-default lispy-outline "^;; \\(?:;[^#]\\|\\*+\\)"
                lispy-outline-header ";; ")
  :config
  (add-hook 'emacs-lisp-mode-hook #'lispy-mode t)
  (add-hook 'lispy-mode-hook #'turn-off-smartparens-mode)
  (map! :map lispy-mode-map
        :i "_" #'special-lispy-different
        :i "C-d" #'lispy-delete
        :i "C-u" #'universal-argument
        :i [remap delete-backward-char] #'lispy-delete-backward))
(def-package! lispyville
  :after (evil)
  :hook (lispy-mode . lispyville-mode)
  :config
  (lispyville-set-key-theme
   '(operators
     c-w
     prettify
     escape
     (slurp/barf-lispy))))
;; *** electric
(def-package! electric-operator
  :hook ((sh-mode . electric-operator-mode)
         (ess-mode . electric-operator-mode)
         (python-mode . electric-operator-mode)))
;; *** smartparens
(after! smartparens
  (add-hook 'minibuffer-setup-hook #'smartparens-mode)
  (add-hook 'eshell-mode-hook #'smartparens-mode)
  ;; Auto-close more conservatively and expand braces on RET
  (sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
  (let ((unless-list '(sp-point-before-word-p
                       sp-point-after-word-p
                       sp-point-before-same-p)))
    (sp-pair "'" nil :unless unless-list)
    (sp-pair "\"" nil :unless unless-list))
  (sp-pair "{" nil :post-handlers '(("||\n[i]" "RET") ("| " " "))
           :unless '(sp-point-before-word-p sp-point-before-same-p))
  (sp-pair "(" nil :post-handlers '(("||\n[i]" "RET") ("| " " "))
           :unless '(sp-point-before-word-p sp-point-before-same-p))
  (sp-pair "[" nil :post-handlers '(("| " " "))
           :unless '(sp-point-before-word-p sp-point-before-same-p)))
(after! yasnippet
  (push "~/.doom.d/snippets" yas-snippet-dirs)
  (add-hook! (comint-mode
              inferior-python-mode
              inferior-ess-mode)
    #'yas-minor-mode-on))
