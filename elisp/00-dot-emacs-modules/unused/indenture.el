(defun indenture ()
  (interactive)
  "Forcibly indent the whole buffer to my preferences."
  (indent-region (point-min) (point-max) 't))
