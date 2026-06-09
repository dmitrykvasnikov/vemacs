;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; functions i need to have for list operations

;; Expand path with emacs config dir
(defun dk/add-to-confdir (relative-path)
  (expand-file-name relative-path user-emacs-directory))

;; Add list of items to a list
;; it expand-p is TRUE each path from the list expanded to emacs config dir
(defun dk/add-paths-to-list (list-var paths &optional expand-p)
  (let ((expander (if expand-p #'dk/add-to-confdir #'identity)))
    (dolist (path paths)
      (add-to-list list-var (funcall expander path)))))
