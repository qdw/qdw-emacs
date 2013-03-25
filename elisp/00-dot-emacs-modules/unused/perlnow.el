;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Coding:  Perl:  perlnow
;; Speed up creation of Perl programs and modules by using templates.

(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp/template"))
(require 'template)
(template-initialize)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp/perlnow"))
(require 'perlnow)
(setq user-mail-address "quinn@fairpath.com")

(defun perlnow-toggle-between-module-and-test ()
  "If the current buffer contains a Perl module, switch to its associated test;
   if the current buffer is a test, switch to its associated Perl module."
  (interactive)
  (cond ((and (symbolp 'perlnow-associated-code) perlnow-associated-code)
         (perlnow-back-to-code))
           
        ((string-match "\\.t$" buffer-file-name)
         (error "This test file is missing a module"))

        ('t
         (perlnow-edit-test-file (perlnow-get-test-file-name)))))

(defun perlnow-debug (run-string)
  "Run the perl debugger on this file (or its associated .pl or test file).

  To determine the file to run, this function uses the same
  algorithm as the rest of perlnow:  If `perlnow-run-string'
  is set, it uses that; otherwise, it prompts for a value
  by calling \\[perlnow-set-run-string] THEEND."
  (interactive
    ; This code was lifted from the function perlnow-run in perlnow.el
    (let (input)
      (if (eq perlnow-run-string nil)
          (setq input (perlnow-set-run-string))
          (setq input perlnow-run-string))
      (list input)))
  ; End lifted code

  (perldb run-string))

(global-set-key '[f1]   'perlnow-object-module)
(global-set-key '[f2]   'perlnow-edit-test-file)
(global-set-key '[f2]   'perlnow-toggle-between-module-and-test)
(global-set-key '[f3]   'perlnow-module)
(global-set-key '[f4]   'perlnow-script)
