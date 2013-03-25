(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp/python-mode"))
(require 'python-mode)

;;;; Broken:
;; 
;; (defun python-test-p ()
;;   (string-match "\\.t$" buffer-file-name))
;; 
;; (defun run-in-shell-if-python-test ()
;;   (if (python-test-p)
;;       (shell-command buffer-file-name)))
;; 
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (add-hook 'after-save-hook 'run-in-shell-if-python-test)))
