;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Coding: Perl + Catalyst + Firefox IDEmacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; Reload the open web page on save,
;; ;; if the current buffer is in moz-reload-on-save-mode.
;; ;; Toggle this mode using C-c m.
;; (load-file (expand-file-name "~/.emacs.d/elisp/mozrepl/moz.elc"))

;; (defun moz-firefox-reload ()
;;   (sleep-for 4) ;; wait for the Catalyst server to restart.
;;   (comint-send-string (inferior-moz-process) "BrowserReload();"))

;; (global-set-key "\C-cm" 'moz-reload-on-save-mode)

;; (define-minor-mode moz-reload-on-save-mode
;;   "Moz Reload On Save Minor Mode"
;;   nil " Reload" nil
;;   (if moz-reload-on-save-mode
;;       ;; Edit hook buffer-locally.
;;       (add-hook 'after-save-hook (moz-firefox-reload) nil t)
;;     (remove-hook 'after-save-hook (moz-firefox-reload) t)))

;; ;; Automatically put Perl files in moz-reload-on-save-mode (see above).
;; ;; This might mean some false-positive reloads, but I don't care.
;; (add-hook 'cperl-mode-hook (lambda () (moz-firefox-reload)))
