;;; ~/.doom.d/+loading.el -*- lexical-binding: t; -*-
;; load time consuming stuff when idle
;;;###autoload
(defun auto-require-packages (packages)
  (let* ((reqs (cl-remove-if #'featurep packages))
         (req (pop reqs)))
    (when req
      (message "Loading %s" req)
      (require req)
      (when reqs
        (run-with-idle-timer 2 nil #'auto-require-packages reqs)))))
;;;###autoload
(defun auto-load-files (files)
  (let ((file (pop files)))
    (when file
      (message "Loading %s" file)
      (find-file-noselect file)
      (when files
        (run-with-idle-timer 2 nil #'auto-load-files files)))))
;; abuse idle timers in a thread to reduce blocking
(make-thread
 (lambda ()
   (run-with-idle-timer 10 nil #'auto-require-packages
    '(dash
      f
      s
      with-editor
      git-commit
      package
      magit
      find-func
      format-spec
      org-macs
      org-compat
      org-faces
      org-entities
      org-list
      org-pcomplete
      org-src
      org-footnote
      org-element
      org-macro
      org
      org-clock
      org-agenda
      org-capture
      org-notmuch
      outline
      outshine
      elisp-mode
      lispy
      avy
      hydra
      message
      org-mime
      ))))
