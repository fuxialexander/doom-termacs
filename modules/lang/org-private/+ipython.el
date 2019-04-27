;;; lang/org-private/+ipython.el -*- lexical-binding: t; -*-
(defvar +org-ob-ipython-resources-dir ".ob-ipython-resrc")
(defvar +ob-ipython-local-runtime-dir
    (substring (shell-command-to-string (concat "jupyter --runtime-dir")) 0 -1))
(def-package! ob-ipython
  :when (featurep! +ipython)
  :after (ob)
  :config
  (setq ob-ipython-resources-dir +org-ob-ipython-resources-dir)
  ;; popup
  (when (featurep! +right-popup)
    (set-popup-rule! "^\\*Org Src" :size 100 :side 'right :slot -1 :height 0.6 :select t)
    (set-popup-rule! "^\\*Python" :slot 0 :side 'right :size 100)
    (set-popup-rule! "\\*ob-ipython.*" :slot 2 :side 'right :size 100 :height 0.2)
    (set-popup-rule! "\\*Python:.*" :slot 0 :side 'right :size 100))
  ;; advices for remote kernel and org-src-edit
  (advice-add 'org-babel-edit-prep:ipython :override #'+org*org-babel-edit-prep:ipython)
  (advice-add 'org-babel-ipython-initiate-session :override #'+org*org-babel-ipython-initiate-session)
  (advice-add 'ob-ipython--create-repl :override #'+org*ob-ipython--create-repl)
  (advice-add 'org-babel-execute:ipython :override #'+org*org-babel-execute:ipython)
  ;; retina resolution image hack
  (when (eq window-system 'ns)
    (advice-add 'ob-ipython--write-base64-string :around #'+org*ob-ipython--write-base64-string)))
