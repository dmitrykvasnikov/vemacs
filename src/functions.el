;; -*- lexical-binding: t; -*-

;; My functions

;; Display statistics @startup
(defun dk/display-startup-time ()
  "Display statistics on start-up"
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))
(add-hook 'emacs-startup-hook #'dk/display-startup-time)

;; Setup orderless match faces
(defun dk/sync-orderless ()
  "Set orderless match faces to use the same background as visual selection."
  (let ((bg (face-attribute 'region :background))
	(fg (face-attribute 'font-lock-string-face :foreground)))
    (dolist (face '(orderless-match-face-0
                    orderless-match-face-1
                    orderless-match-face-2
                    orderless-match-face-3))
      (set-face-attribute face nil :foreground fg :background 'unspecified :underline t))))

;; Show help for variable at point
(defun dk/help-on-variable-at-point ()
  "Show help for the variable at point."
  (interactive)
  (let ((symbol (symbol-at-point)))
    (cond
     ((null symbol)
      (message "No symbol at point"))
     ((boundp symbol)
      (describe-variable symbol))
     ((fboundp symbol)
      (describe-function symbol))
     (t
      (message "'%s' not a variable or function!" symbol)))))

