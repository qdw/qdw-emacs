;; Stuff for later versions of Aquamacs - turned off for now.
(if (and (featurep 'aquamacs) (eq aquamacs-version "1.9"))
    ;; To indicate lines that are longer than the buffer is wide,
    ;; show a "fringe" at the edge of the buffer.
    ;; I've chosen to have no fringe (0) at the left and a 24-pixel-wide
    ;; fringe (24) at the right.
    ((set-fringe-mode '(0 24)) 
    (custom-set-variables
     '(custom-file "~/.emacs")
     '(default-frame-alist (width . 80) (height . 45))
     '(aquamacs-styles-mode nil nil (color-theme))
     '(one-buffer-one-frame-mode nil nil (aquamacs-frame-setup))
     '(x-select-enable-clipboard t))))
