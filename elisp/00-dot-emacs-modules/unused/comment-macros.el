;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Macros for manipulating comments

;; from http://www.emacswiki.org/cgi-bin/wiki/extraedit.el
;; comment out current line
(defun line-comment()
  "Comments out current line."
  (interactive)
  (comment-region (line-beginning-position) (+ 1 (line-end-position))))

;; from http://www.emacswiki.org/cgi-bin/wiki/extraedit.el
;; Uncomment current line
(defun line-uncomment()
  "Uncomments current line."
  (interactive)
  (uncomment-region (line-beginning-position) (+ 1 (line-end-position))))

;; from http://www.emacswiki.org/cgi-bin/wiki/extraedit.el
;; Comment out a paragraph and duplicate it
(defun para-comment-and-duplicate()
  "Comment out a paragraph and duplicate it"
  (interactive)
  (let ((beg (line-beginning-position))
        (end (save-excursion (forward-paragraph) (point))))
    (copy-region-as-kill beg end)
    (para-comment-forward)
    (yank)))
