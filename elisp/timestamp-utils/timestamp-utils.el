(defvar current-date-time-format "%Y-%_m-%d"
  "Format of date to insert with `insert-current-date-time' func
See the help text of `format-time-string' for possible replacements")

(defvar current-time-format ""%Y-%m-%dT%T%z""
  "Format of date to insert with `insert-current-time' func.
See the help text of `format-time-string' for possible replacements")

(defun insert-current-date-time ()
  "Insert the current date and time into current buffer.
Use `current-date-time-format' for the formatting the date/time"
  (interactive)
  (insert "==========\n")
                                        ;       (insert (let () (comment-start)))
  (insert (format-time-string current-date-time-format (current-time)))
  (insert "\n"))

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
  (interactive)
  (insert (format-time-string current-time-format (current-time)))
  (insert "\n"))

(global-set-key "\C-c\C-d" 'insert-current-date-time)
(global-set-key "\C-c\C-t" 'insert-current-time)
