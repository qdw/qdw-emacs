;; Setting up a decent JavaScript mode is hard. This hack, based on code from
;; http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode ,
;; does it.

;; In order to get some bugfixes, use the latest version of js2-mode,
;; not the one that comes bundled with emacs.
(load-file
 (expand-file-name
  "~/.emacs.d/elisp/js2-mode/js2-mode-read-only/build/js2-emacs22.elc"))
(autoload 'js2-mode "js2-mode" nil t)

(remove-from-list
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; js2-mode is awesome, but its indentation has some shortcomings,
;; so monkey-patch it to use espresso.el's indentation instead.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'espresso-mode "espresso")
(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso-proper-indentation parse-status))
           node)

      (save-excursion

        ;; I like to indent case and labels to half of the tab width
        ;; [-- mihai, the original author]
        ;;
        ;; Well, I don't, so I'm commenting this out.
        ;; --qdw
        ;;
        ;;(back-to-indentation)
        ;;(if (looking-at "case\\s-")
        ;;    (setq indentation (+ indentation (/ espresso-indent-level 2))))

        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation (+ 4 indentation))))

      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))

;; Add an "indent innermost block" function (works like c-mode's `c-indent-exp')

;; Detailed commentary by mihai:
;;
;;   If you used c-mode (which I did, for years) then you know that there's a
;;   neat key binding M-C-q which indents the block starting with the paren
;;   under the cursor.  The following function implements this generically and
;;   can be used in js2-mode:

;;   Unlike c-indent-exp, my function above does not require the cursor to be
;;   over a paren.  It looks up the innermost block using (syntax-ppss) which is
;;   a neat function provided by Emacs, and reindents it.  It also highlights
;;   the block for half a second—I just learned to use overlays in Elisp and
;;   think they're cool. :-p

(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))
