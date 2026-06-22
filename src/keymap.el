;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keyboard mappings

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-x C-r") #'recentf-open)
(global-set-key (kbd "C-x C-b") #'ibuffer)
(global-set-key (kbd "M-o") #'other-window)
(global-set-key (kbd "M-/") #'comment-or-uncomment-region)
(global-set-key (kbd "C-c t") #'consult-theme)
(global-set-key (kbd "S-<return>") (kbd "C-e C-m"))
(global-set-key (kbd "C-=") #'er/expand-region)
(global-set-key (kbd "M-u") #'upcase-dwim)
(global-set-key (kbd "M-l") #'downcase-dwim)
(global-set-key (kbd "M-c") #'capitalize-dwim)
(global-set-key (kbd "C-c r") #'cua-mode)
(global-set-key (kbd "M-x") #'dk/M-x-dwim)
(defun dk/kill-buffer-smart ()
  "Kill current buffer without prompt if unmodified.
If modified, ask to save before killing.
Choosing 'n' kills without saving (no second prompt)."
  (interactive)
  (if (and buffer-file-name (buffer-modified-p))
      ;; Modified file buffer: ask to save
      (if (y-or-n-p (format "Save %s before killing? " buffer-file-name))
          ;; User says yes: save then kill
          (progn
            (save-buffer)
            (kill-buffer (current-buffer)))
        ;; User says no: kill without saving, no second prompt
        (kill-buffer nil)
    ;; Unmodified or non-file buffer: kill without prompt
    (kill-buffer (current-buffer)))))
;; Bind to a key (e.g., C-x k)
(global-set-key (kbd "C-x k") #'dk/kill-buffer-smart)

(provide 'keymap)
;;; keymap.el ends here
