;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keyboard mappings

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-x C-r") #'recentf-open)
(global-set-key (kbd "C-x C-b") #'ibuffer)
(global-set-key (kbd "M-o") #'other-window)
(global-set-key (kbd "M-/") #'comment-or-uncomment-region)
(global-set-key (kbd "C-c t") #'consult-theme)
(global-set-key (kbd "C-RET") (kbd "C-e C-m"))
(global-set-key (kbd "C-=") #'er/expand-region)

(provide 'keymap)
;;; keymap.el ends here
