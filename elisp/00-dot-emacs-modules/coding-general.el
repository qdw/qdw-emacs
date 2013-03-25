;;;;;;;;;;;;;;;;;;;
;; Coding: general

;; Don't color my syntax.
(global-font-lock-mode -1)

;; Don't use tabs for indentation.
(setq-default indent-tabs-mode nil)

;; Don't auto-insert line breaks when my lines exceed 80 characters!
(auto-fill-mode 0)

;; Automatically make scripts executable when saving them.
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; Keyboard shortcuts
(global-set-key "\C-ci" 'indent-region)
(global-set-key "\C-cc" 'comment-region)
(global-set-key "\C-cu" 'uncomment-region)
(global-set-key "\M-5"   'query-replace-regexp)
