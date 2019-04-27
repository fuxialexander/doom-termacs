;;; lang/org-private/autoload/org-latex.el -*- lexical-binding: t; -*-
;;;###if (featurep! +latex)

;;;###autoload
(defun +org-toggle-math ()
  (interactive)
  (if (bound-and-true-p org-cdlatex-mode)
      (org-cdlatex-mode -1)
    (org-cdlatex-mode +1))
  (if (bound-and-true-p webkit-katex-render-mode)
      (webkit-katex-render-mode -1)
    (webkit-katex-render-mode +1)))
