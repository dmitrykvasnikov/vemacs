;; -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; User settings and variables
(setq-default user-full-name "Dmitry Kvasnikov"
	      user-mail-address "dmitry.kvasnikov@gmail.com")

;; Config load paths and load external files
(dk/add-paths-to-list 'load-path '("src") t)
(dk/add-paths-to-list 'custom-theme-load-path '("themes/") t)
(load "functions.el" nil t)
(load "keymap.el" nil t)
(setopt custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package settings
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
				 ("org" . "https://orgmode.org/elpa/")
				 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Common settings
(fset 'yes-or-no-p 'y-or-n-p)
(setq make-backup-files nil)         ;; do not make backup files
(setq create-lockfiles nil)
(setq auto-save-dir (expand-file-name "autosave" user-emacs-directory))
(make-directory auto-save-dir t)
(setq auto-save-file-name-transforms
	      `((".*" ,auto-save-dir t)))
(setq vc-follow-symlinks t)		;; Follow symlinks without confirmation
(setq delete-by-moving-to-trash (not noninteractive))
(setq visible-bell -1)
(setq ring-bell-function #'ignore)
(delete-selection-mode t)
(setopt custom-file (locate-user-emacs-file "custom.el"))
(savehist-mode 1)
(save-place-mode 1)
(setq undo-limit (* 13 160000)
	      undo-strong-limit (* 13 240000)
	      undo-outer-limit (* 13 24000000))
(setq gc-cons-threshold (* 50 1000 1000))
(setq initial-scratch-message ";; He who walks alone  ... Always walks uphill but ... Beneath his feet are the ... Broken bones of flawed men ...\n\n")
;; Search settings
(setq isearch-allow-scroll t)
(setq isearch-lazy-count t)
(setq isearch-wrap-pause 'no-ding)
(setq isearch-repeat-on-direction-change t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UI Settings
(setq inhibit-startup-message t)
(scroll-bar-mode -1)       
(tool-bar-mode -1)         
(tooltip-mode -1)          
(set-fringe-mode 10)       
(menu-bar-mode -1)         
(blink-cursor-mode -1)
(column-number-mode)
(xterm-mouse-mode 1)
(electric-pair-mode 1)
(setq scroll-preserve-screen-position t)
(setq scroll-conservatively 20)
(setq word-wrap t)
(setq tab-always-indent t)
;; Screen positioninig
(setq recenter-positions '(middle top))
(setq scroll-preserve-screen-position t)
(setq scroll-conservatively 1000)
(setq scroll-margin 3)
(setq next-screen-context-lines 3)
;; Fonts
(set-face-attribute 'default nil :family "Aporetic Sans Mono" :height 115)
(set-face-attribute 'minibuffer-prompt nil :family "Aporetic Sans Mono" :height 100)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages
(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package helpful
   :custom
  (helpful-switch-buffer-function #'dk/helpful-open)
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h x" . helpful-command)
   ("C-h C-h" . helpful-at-point)
   :map helpful-mode-map
   ("C-g" . dk/helpful-close)
   ("<escape>" . dk/helpful-close)))
 
(use-package which-key
  :defer 0
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package display-line-numbers
  :hook prog-mode
  :custom
  (display-line-numbers-type 'relative)
  (display-line-numbers-width 3)
  (display-line-numbers-grow-only t))

(use-package recentf
  :custom
  (recentf-max-menu-items 15)
  (recentf-max-saved-items 300)
  :init (recentf-mode))

(use-package vertico
  :hook (after-init . vertico-mode)
  :init (vertico-mode)
  :custom
  (vertico-count 15)
  (vertico-cycle t)
  (vertico-resize nil)
  (vertico-scroll-margin 7))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t))

(use-package marginalia
  :after vertico
  :init (marginalia-mode))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :config
  (setq dired-listing-switches "-agho --group-directories-first"
        dired-recursive-copies 'always
        dired-recursive-deletes 'always
        dired-dwim-target t
	dired-kill-when-opening-new-dired-buffer t))

(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package projectile
  :diminish projectile-mode  ; Removes projectile from mode line (optional)
  :init
  (setq projectile-track-known-projects-automatically t)  ; Auto-add projects
  (setq projectile-require-project-root nil)              ; Work in any directory
  (setq projectile-cache-file (expand-file-name "projectile.cache" user-emacs-directory))
  :config
  (projectile-mode +1)
  ;; Basic settings
  (setq projectile-completion-system 'default)
  (setq projectile-indexing-method 'alien)       ; Faster on Unix (Linux/Mac)
  (setq projectile-sort-order 'recently-active)
  (setq projectile-switch-project-action 'projectile-dired)
  
  ;; Ignore certain directories for better performance
  (nconc  projectile-globally-ignored-directories 
        '(".idea" ".ensime" ".ccls-cache" "node_modules" 
          "dist" "build" "target"))
  (nconc projectile-globally-ignored-files
        '("*.pyc" "*.o" "*.class" ".DS_Store" "*.elc"))  
  ;; Key bindings
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  ;; Optional: Show file name in modeline
  (setq projectile-mode-line '(:eval (format " P[%s]" (projectile-project-name)))))

(use-package consult
  :bind (;; Buffer navigation
         ("C-x b" . consult-buffer)           ;; Switch buffer (replaces C-x C-b)
	 ("C-x 4 b" . consult-buffer-other-window)
         ("C-c C-f" . consult-find)           ;; Find file (replaces default)
         ("C-x C-p" . consult-project-find)   ;; Find file in project (IF you use project.el)
         ("C-s" . consult-line)               ;; Search line in buffer
         ("C-x C-r" . consult-recent-file)    ;; Recent files
	 ("C-c ?" . consult-flymake)
	 ("C-c m" . consult-mode-command)
         ("C-r" . consult-history)            ;; Minibuffer history
	 ("M-y" . consult-yank-pop)
         )
  :custom
  (consult-preview-key 'any)              ;; Preview while typing
  (consult-preview-delay 0)               ;; No delay
  (consult-line-numbers-widen t)          ;; Show line numbers in search
  )

(use-package consult-projectile
  :after projectile
  :bind
  (("C-c p f" . consult-projectile-find-file)
   ("C-c p p" . consult-projectile-switch-project)
   ("C-c p b" . consult-projectile-switch-to-buffer)
   ("C-c p d" . consult-projectile-find-dir))
  :config
  (setq consult-projectile-function #'consult-projectile))
(global-set-key (kbd "C-<return>") "\C-e\C-m")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme settings
(add-hook 'enable-theme-functions
	  (lambda (theme)
	    (message "Theme enabled: %s" theme)
	    (dk/sync-orderless)))
(setq custom-safe-themes t)
(use-package doom-themes)
(use-package ef-themes)
(use-package gruvbox-theme)
(use-package spacemacs-theme)
(load-theme 'gruber-darker)
