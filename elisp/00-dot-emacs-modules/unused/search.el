(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp/findr")
(autoload 'findr-query-replace "findr" "Replace text in files." t)
(define-key global-map [(meta control r)] 'findr-query-replace)
