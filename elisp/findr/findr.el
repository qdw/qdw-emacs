<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: findr.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=findr.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: findr.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=findr.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/emacs/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/emacs/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/emacs/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for findr.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=findr.el" /><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head><body class="http://www.emacswiki.org/emacs"><div class="header"><a class="logo" href="http://www.emacswiki.org/emacs/SiteMap"><img class="logo" src="/emacs_logo.png" alt="[Home]" /></a><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/Glossary">Glossary</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span>
<!-- Google CSE Search Box Begins  -->
<form class="tiny" action="http://www.google.com/cse" id="searchbox_004774160799092323420:6-ff2s0o6yi"><p>
<input type="hidden" name="cx" value="004774160799092323420:6-ff2s0o6yi" />
<input type="text" name="q" size="25" />
<input type="submit" name="sa" value="Search" />
</p></form>
<script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=searchbox_004774160799092323420%3A6-ff2s0o6yi"></script>
<!-- Google CSE Search Box Ends -->
<h1><a title="Click to search for references to this page" rel="nofollow" href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&amp;q=%22findr.el%22">findr.el</a></h1></div><div class="wrapper"><div class="wrapper"><div class="content browse"><p class="download"><a href="http://www.emacswiki.org/emacs/download/findr.el">Download</a></p><pre class="code"><span class="linecomment">;;; findr.el -- Breadth-first file-finding facility for (X)Emacs</span>
<span class="linecomment">;;  Sep 27, 2008</span>

<span class="linecomment">;; Copyright (C) 1999 Free Software Foundation, Inc.</span>

<span class="linecomment">;; Author: David Bakhash &lt;cadet@bu.edu&gt;</span>
<span class="linecomment">;; Maintainer: David Bakhash &lt;cadet@bu.edu&gt;</span>
<span class="linecomment">;; Version: 0.7</span>
<span class="linecomment">;; Created: Tue Jul 27 12:49:22 EST 1999</span>
<span class="linecomment">;; Keywords: files</span>

<span class="linecomment">;; This file is not part of emacs or XEmacs.</span>

<span class="linecomment">;; This file is free software; you can redistribute it and/or</span>
<span class="linecomment">;; modify it under the terms of the GNU General Public License as</span>
<span class="linecomment">;; published by the Free Software Foundation; either version 2 of the</span>
<span class="linecomment">;; License, or (at your option) any later version.</span>

<span class="linecomment">;; This program is distributed in the hope that it will be useful,</span>
<span class="linecomment">;; but WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="linecomment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU</span>
<span class="linecomment">;; General Public License for more details.</span>

<span class="linecomment">;; You should have received a copy of the GNU General Public License</span>
<span class="linecomment">;; along with XEmacs; see the file COPYING.  If not, write to the Free</span>
<span class="linecomment">;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA</span>
<span class="linecomment">;; 02111-1307, USA.</span>


<span class="linecomment">;;; Commentary:</span>

<span class="linecomment">;; This code contains a command, called `findr', which allows you to</span>
<span class="linecomment">;; search for a file breadth-first.  This works on UNIX, Windows, and</span>
<span class="linecomment">;; over the network, using efs and ange-ftp. It's pretty quick, and (at</span>
<span class="linecomment">;; times) is a better and easier alternative to other mechanisms of</span>
<span class="linecomment">;; finding nested files, when you've forgotten where they are.</span>

<span class="linecomment">;; You pass `findr' a regexp, which must match the file you're looking</span>
<span class="linecomment">;; for, and a directory, and then it just does its thing:</span>

<span class="linecomment">;; M-x findr &lt;ENTER&gt; ^my-lib.p[lm]$ &lt;ENTER&gt; c:/ &lt;ENTER&gt;</span>

<span class="linecomment">;; If called interactively, findr will prompt the user for opening the</span>
<span class="linecomment">;; found file(s).  Regardless, it will continue to search, until</span>
<span class="linecomment">;; either the search is complete or the user quits the search.</span>
<span class="linecomment">;; Regardless of the exit (natural or user-invoked), a findr will</span>
<span class="linecomment">;; return a list of found matches.</span>

<span class="linecomment">;; Two other entrypoints let you to act on regexps within the files:</span>
<span class="linecomment">;; `findr-search' to search</span>
<span class="linecomment">;; `findr-query-replace' to replace</span>


<span class="linecomment">;;; Installation:</span>

<span class="linecomment">;; (autoload 'findr "findr" "Find file name." t)</span>
<span class="linecomment">;; (define-key global-map [(meta control S)] 'findr)</span>

<span class="linecomment">;; (autoload 'findr-search "findr" "Find text in files." t)</span>
<span class="linecomment">;; (define-key global-map [(meta control s)] 'findr-search)</span>

<span class="linecomment">;; (autoload 'findr-query-replace "findr" "Replace text in files." t)</span>
<span class="linecomment">;; (define-key global-map [(meta control r)] 'findr-query-replace)</span>


<span class="linecomment">;; Change Log:</span>

<span class="linecomment">;; 0.1: Added prompt to open file, if uses so chooses, following</span>
<span class="linecomment">;;      request and code example from Thomas Plass.</span>
<span class="linecomment">;; 0.2: Made `findr' not stop after the first match, based on the</span>
<span class="linecomment">;;      request by Thomas Plass.</span>
<span class="linecomment">;;      Also, fixed a minor bug where findr was finding additional</span>
<span class="linecomment">;;      files that were not correct matches, based on</span>
<span class="linecomment">;;      `file-relative-name' misuse (I had to add the 2nd arg to it).</span>
<span class="linecomment">;; 0.3: Added a `sit-for' for redisplay reasons.</span>
<span class="linecomment">;;      Modifications as suggested by RMS: e.g. docstring.</span>
<span class="linecomment">;; 0.4  Added `findr-query-replace', courtesy of Dan Nelsen.</span>
<span class="linecomment">;; 0.5  Fixed spelling and minor bug in `findr-query-replace' when</span>
<span class="linecomment">;;      non-byte-compiled.</span>
<span class="linecomment">;; 0.6  http://groups.google.com/groups?selm=cxjhfml4b2c.fsf_-_%40acs5.bu.edu :</span>
<span class="linecomment">;; From: David Bakhash (cadet@bu.edu)</span>
<span class="linecomment">;; Subject: Re: latest version of findr.el (5)</span>
<span class="linecomment">;; Date: 1999/07/31</span>
<span class="linecomment">;; Courtesy of Dan Nelsen, this version has search-and-replace capabilities.</span>
<span class="linecomment">;; it's still a bit experimental, so I wouldn't expect too much of it.  But it</span>
<span class="linecomment">;; hasn't been tested yet for friendly behavior.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; The function `findr-query-replace' wasn't working unless you byte-compile the</span>
<span class="linecomment">;; file.  But, since findr is really designed for speed, that's not a bad thing</span>
<span class="linecomment">;; (i.e. it forces you to byte-compile it).  It's as simple as:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; M-x byte-compile-file &lt;ENTER&gt; /path/to/findr.el &lt;ENTER&gt;</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; anyhow, I think it should work now.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; dave</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; 0.7: Added `findr-search', broke `findr' by Patrick Anderson</span>
<span class="linecomment">;; 0.8: fixed 0.7 breakage by Patrick Anderson</span>
<span class="linecomment">;; 0.9: Added customize variables, added file/directory filter regexp</span>
<span class="linecomment">;;      minibuffer history by attila.lendvai@gmail.com</span>
<span class="linecomment">;; 0.9.1: Updated date at the top of the file, added .svn filter</span>
<span class="linecomment">;; 0.9.2: Added support for skipping symlinks by attila.lendvai@gmail.com</span>
<span class="linecomment">;; 0.9.3: Smarter minibuffer handling by attila.lendvai@gmail.com</span>
<span class="linecomment">;; 0.9.4: Better handle symlinks by levente.meszaros@gmail.com</span>
<span class="linecomment">;; 0.9.5: Collect resolved files in the result by attila.lendvai@gmail.com</span>
<span class="linecomment">;; 0.9.6: Use a seen hashtable to deal with circles through symlinks by attila.lendvai@gmail.com</span>
<span class="linecomment">;; 0.9.7: Fix wrong calls to message by Michael Heerdegen</span>
<span class="linecomment">;; 0.9.8: Fix 'symbol-calue' typo in non-exposed code path by Michael Heerdegen</span>
<span class="linecomment">;; 0.9.9: Call message less frequent by attila.lendvai@gmail.com</span>
<span class="linecomment">;; 0.9.10: match findr-skip-directory-regexp agaisnt the whole path by attila.lendvai@gmail.com</span>

(require 'cl)

(provide 'findr)

(defgroup findr nil
  "<span class="quote">findr configuration.</span>"
  :prefix "<span class="quote">findr-</span>"
  :group 'findr)

<span class="linecomment">;; To build the expression below:</span>
<span class="linecomment">;;(let ((result nil))</span>
<span class="linecomment">;;  (dolist (el (list ".backups" "_darcs" ".git" "CVS" ".svn"))</span>
<span class="linecomment">;;    (setf result (if result</span>
<span class="linecomment">;;                     (concatenate 'string result "\\|")</span>
<span class="linecomment">;;                     ""))</span>
<span class="linecomment">;;    (setf result (concatenate 'string result "^" (regexp-quote el) "$")))</span>
<span class="linecomment">;;  result)</span>

(defcustom findr-skip-directory-regexp "<span class="quote">\\/.backups$\\|/_darcs$\\|/\\.git$\\|/CVS$\\|/\\.svn$</span>"
  "<span class="quote">A regexp filter to skip directory paths.</span>"
  :type 'string
  :group 'findr)

(defcustom findr-skip-file-regexp "<span class="quote">^[#\\.]</span>"
  "<span class="quote">A regexp that all file names will be matched against (including directories) and matching files are skipped.</span>"
  :type 'string
  :group 'findr)

(defvar findr-search-regexp-history nil)
(defvar findr-search-replacement-history nil)
(defvar findr-file-name-regexp-history nil)
(defvar findr-directory-history nil)

(defun findr-propertize-string (string properties)
  (add-text-properties 0 (length string) properties string)
  string)

(defmacro findr-with-infrequent-message (&rest body)
  (let ((last-message-at (gensym "<span class="quote">last-message-at</span>")))
    `(let ((,last-message-at 0))
       (labels ((message* (message &rest args)
                  (when (&gt; (- (time-to-seconds) ,last-message-at) 0.5)
                    (setq ,last-message-at (time-to-seconds))
                    (apply 'message message args))))
         ,@body))))

(defun findr-propertize-prompt (string)
  (findr-propertize-string string '(read-only t intangible t)))

(defun* findr-read-from-minibuffer (prompt history &key initial-content
                                           store-empty-answer-in-history)
  (let ((minibuffer-message-timeout 0)
        (history-position (position initial-content (symbol-value history)
                                    :test 'string=)))
    (let ((result (read-from-minibuffer
                   (findr-propertize-prompt prompt)
                   initial-content nil nil (if (and (not (consp history))
                                                    history-position)
                                               (cons history (1+ history-position))
                                               history))))
      (when (and store-empty-answer-in-history
                 (zerop (length result)))
        (setf (symbol-value history)
              (delete-if (lambda (el)
                           (zerop (length el)))
                         (symbol-value history)))
        (push result (symbol-value history)))
      result)))

(defun* findr-read-from-minibuffer-defaulting (prompt history &key store-empty-answer-in-history)
  (let* ((default (if (consp history)
                      (elt (symbol-value (car history)) (cdr history))
                      (first (symbol-value history))))
         (result (findr-read-from-minibuffer
                  (format prompt (or default "<span class="quote"></span>"))
                  history
                  :store-empty-answer-in-history store-empty-answer-in-history)))
    (if (= (length result) 0)
        default
        result)))

(defun findr-read-search-regexp (&optional prompt)
  (findr-read-from-minibuffer-defaulting
   "<span class="quote">Search through files for (regexp, default: \"%s\"): </span>"
   'findr-search-regexp-history))

(defun findr-read-file-regexp (&optional prompt)
  (findr-read-from-minibuffer
   "<span class="quote">Look in these files (regexp): </span>"
   'findr-file-name-regexp-history
   :initial-content (first findr-file-name-regexp-history)
   :store-empty-answer-in-history t))

(defun findr-read-starting-directory (&optional prompt)
  (setq prompt (or prompt "<span class="quote">Start in directory: </span>"))
  (if (and (fboundp 'ido-read-directory-name)
           ido-mode)
      (ido-read-directory-name prompt)
      (apply 'read-directory-name
             (append
              (list prompt default-directory default-directory t nil)
              (when (featurep 'xemacs)
                (list 'findr-directory-history))))))

<span class="linecomment">;;;; breadth-first file finder...</span>

(defun* findr (name dir &key (prompt-p (interactive-p)) (skip-symlinks nil) (resolve-symlinks t))
  "<span class="quote">Search directory DIR breadth-first for files matching regexp NAME.
If PROMPT-P is non-nil, or if called interactively, Prompts for visiting
search result\(s\).</span>"
  (findr-with-infrequent-message
    (let ((*dirs* (findr-make-queue))
          (seen-directories (make-hash-table :test 'equal))
          *found-files*)
      (labels ((findr-1 (dir)
                 (message* "<span class="quote">Collecting in dir %s</span>" dir)
                 (let ((files (directory-files dir t "<span class="quote">\\w</span>")))
                   (loop
                     for file in files
                     for fname = (file-relative-name file dir)
                     when (and (file-directory-p file)
                               (not (string-match findr-skip-directory-regexp file))
                               (not (gethash (file-truename file) seen-directories))
                               (or (not skip-symlinks)
                                   (not (file-symlink-p file))))
                     do (progn
                          (print file)
                          (setf (gethash (file-truename file) seen-directories) t)
                          (findr-enqueue file *dirs*))
                     when (and (string-match name fname)
                               (not (string-match findr-skip-file-regexp fname))
                               (or (not skip-symlinks)
                                   (not (file-symlink-p file))))
                     do
                     <span class="linecomment">;; Don't return directory names when</span>
                     <span class="linecomment">;; building list for `tags-query-replace' or `tags-search'</span>
                     <span class="linecomment">;;(when (and (file-regular-p file)</span>
                     <span class="linecomment">;;           (not prompt-p))</span>
                     <span class="linecomment">;;  (push file *found-files*))</span>

                     <span class="linecomment">;; _never_ return directory names</span>
                     (when (file-regular-p file)
                       (push (if resolve-symlinks
                                 (file-truename file)
                                 file)
                             *found-files*))
                     (message* "<span class="quote">Collecting file %s</span>" file)
                     (when (and prompt-p
                                (y-or-n-p (format "<span class="quote">Find file %s? </span>" file)))
                       (find-file file)
                       (sit-for 0)	<span class="linecomment">; redisplay hack</span>
                       )))))
        (unwind-protect
             (progn
               (findr-enqueue dir *dirs*)
               (while (findr-queue-contents *dirs*)
                 (findr-1 (findr-dequeue *dirs*)))
               (message "<span class="quote">Searching... done.</span>"))
          (return-from findr (nreverse *found-files*)))))))

(defun findr-query-replace (from to name dir)
  "<span class="quote">Do `query-replace-regexp' of FROM with TO, on each file found by findr.
If you exit (\\[keyboard-quit] or ESC), you can resume the query replace
with the command \\[tags-loop-continue].</span>"
  (interactive (let ((search-for (findr-read-search-regexp "<span class="quote">Search through files for (regexp): </span>")))
                 (list search-for
                       (findr-read-from-minibuffer-defaulting
                        (format "<span class="quote">Query replace '%s' with %s: </span>"
                                search-for "<span class="quote">(default: \"%s\")</span>")
                        'findr-search-replacement-history)
                       (findr-read-file-regexp)
                       (findr-read-starting-directory))))
  (tags-query-replace from to nil '(findr name dir)))

(defun findr-search (regexp files dir)
  "<span class="quote">Search through all files listed in tags table for match for REGEXP.
Stops when a match is found.
To continue searching for next match, use command \\[tags-loop-continue].</span>"
  (interactive (list (findr-read-search-regexp)
                     (findr-read-file-regexp)
                     (findr-read-starting-directory)))
  (tags-search regexp '(findr files dir)))


(defun findr-find-files (files dir)
  "<span class="quote">Same as `findr' except file names are put in a compilation buffer.</span>"
  (interactive (list (findr-read-file-regexp)
                     (findr-read-starting-directory)))
  <span class="linecomment">;; TODO: open a scratch buffer or store in the clipboard</span>
  (mapcar (lambda (file)
            (message "<span class="quote">%s</span>" file))
          (findr files dir)))

<span class="linecomment">;;;; Queues</span>

(defun findr-make-queue ()
  "<span class="quote">Build a new queue, with no elements.</span>"
  (let ((q (cons nil nil)))
    (setf (car q) q)
    q))

(defun findr-enqueue (item q)
  "<span class="quote">Insert item at the end of the queue.</span>"
  (setf (car q)
        (setf (rest (car q))
              (cons item nil)))
  q)

(defun findr-dequeue (q)
  "<span class="quote">Remove an item from the front of the queue.</span>"
  (prog1 (pop (cdr q))
    (when (null (cdr q))
      (setf (car q) q))))

(defsubst findr-queue-contents (q)
  (cdr q))

<span class="linecomment">;;; findr.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/Glossary">Glossary</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=findr.el;missing=de_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="comment local" href="http://www.emacswiki.org/emacs/Comments_on_findr.el">Talk</a> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=findr.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=findr.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=findr.el">Administration</a></span><!-- test --><span class="time"><br /> Last edited 2011-04-19 16:06 UTC by <a class="author" title="from adsl-89-132-1-111.monradsl.monornet.hu" href="http://www.emacswiki.org/emacs/attila.lendvai">attila.lendvai</a> <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=findr.el">(diff)</a></span><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
