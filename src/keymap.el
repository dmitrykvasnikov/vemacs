;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keyboard mappings

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-x C-r") #'recentf-open)
(global-set-key (kbd "C-x C-b") #'ibuffer)
(global-set-key (kbd "M-/") #'comment-or-uncomment-region)
(global-set-key (kbd "C-c t") #'consult-theme)
