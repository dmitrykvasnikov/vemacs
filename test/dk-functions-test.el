;;; dk-functions-test.el --- Configuration regressions -*- lexical-binding: t; -*-
(require 'ert)
(require 'cl-lib)
(require 'dk-functions)
(defvar go-ts-mode-hook)
(defvar dk/eglot-connecting-server)

(ert-deftest dk/xref-disconnected-allows-fallback ()
  (with-temp-buffer
    (setq buffer-file-name "/tmp/example.go" major-mode 'go-ts-mode)
    (let ((go-ts-mode-hook '(eglot-ensure))
          (dk/eglot-connect-wait 0))
      (should-not (dk/xref-wait-for-eglot)))))

(ert-deftest dk/xref-waits-only-for-live-starting-server ()
  (with-temp-buffer
    (let ((dk/eglot-connecting-server 'server)
          (dk/eglot-connect-wait 1)
          (managed nil))
      (cl-letf (((symbol-function 'jsonrpc-running-p) (lambda (_) t))
                ((symbol-function 'dk/eglot-managed-p) (lambda () managed))
                ((symbol-function 'accept-process-output)
                 (lambda (&rest _) (setq managed t))))
        (dk/xref-wait-for-eglot)
        (should managed)))))

(ert-deftest dk/treesit-missing-grammars-preserve-classic-modes ()
  (let ((major-mode-remap-alist nil)
        (auto-mode-alist auto-mode-alist))
    (cl-letf (((symbol-function 'treesit-language-available-p) (lambda (&rest _) nil)))
      (load "dk-treesit" nil t)
      (should-not (alist-get 'c-mode major-mode-remap-alist))
      (should-not rust-mode-treesitter-derive)
      (should (eq treesit-auto-install-grammar 'never)))))
