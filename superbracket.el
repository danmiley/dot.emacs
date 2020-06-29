;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File		     - superbracket.el
;; Description	     - 
;; Author	     - Tim Bradshaw (tfb at lostwithiel.tfeb.org)
;; Created On	     - Mon Oct  4 14:35:40 1999
;; Last Modified On  - Mon Oct  4 15:03:37 1999
;; Last Modified By  - Tim Bradshaw (tfb at lostwithiel.tfeb.org)
;; Update Count	     - 5
;; Status	     - Unknown
;; 
;; $Id: superbracket.el,v 1.1 1999/10/04 14:04:56 tfb Exp $
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; superbrackets from ilisp (5.7: ilisp-ext.el, changed a bit)
;;;
;;; This should work OK in lisp, scheme modes.  It would work in elisp
;;; too, but it makes it hard to type vectors.
;;;

(provide 'superbracket)

(defun lisp-superbracket (arg)
  "Unless you are in a string, insert right parentheses as necessary
to balance unmatched left parentheses back to the start of the current
defun or to a previous left bracket which is then replaced with a left
parentheses.  If there are too many right parentheses, remove them
unless there is text after the extra right parentheses.  If called
with a prefix, the entire expression will be closed and all open left
brackets will be replaced with left parentheses."
  ;; this pretty much knows it is bound to "]".
  (interactive "P")
  (if (memq (buffer-syntactic-context) '(string comment))
      (insert "]")
    (let* ((point (point))
	   (begin (progn (beginning-of-defun) (point)))
	   (end (progn 
		  (condition-case nil
		      (end-of-defun) 
		    (error (goto-char point)))
		    (point)))
	   inserted
	   (closed nil))
      (goto-char point)
      (if (= begin end)
	  (error "No sexp to close.")
	(save-restriction
	  (narrow-to-region begin end)
	  (if (< point begin) 
	      (setq point begin)
	    (if (> point end)
		(setq point end)))
	  ;; Add parens at point until either the defun is closed, or we
	  ;; hit a square bracket.
	  (goto-char point)
	  (insert ?\))			;So we have an sexp
	  (while (progn
		   (setq inserted (point))
		   (condition-case () 
		       (progn (backward-sexp)
			      (or arg 
				  (not (eq (char-after (point)) ?\[))))
		     (error (setq closed t) nil)))
	    ;; With an arg replace all left brackets
	    (if (and arg (= (char-after (point)) ?\[))
		(progn
		  (delete-char 1)
		  (insert ?\()
		  (backward-char)))
	    (forward-sexp)
	    (insert ?\)))
	  (if (< (point) point)
	      ;; We are at a left bracket
	      (let ((left (point)))
		(delete-char 1)
		(insert ?\()
		(backward-char)
		(forward-sexp))
	    ;; There was not an open left bracket so close at end
	    (delete-region point inserted)
	    (goto-char begin)
	    (if (condition-case () (progn
				     (forward-sexp)
				     (<= (point) end))
		  (error nil))
		;; Delete extra right parens
		(let ((point (point)))
		  (skip-chars-forward " \t)\n")
		  (if (or (bolp) (eobp))
		      (progn
			(skip-chars-backward " \t\n")
			(delete-region point (point)))
		    (error
		     "There is text after the last right parentheses.")))
	      ;; Insert parens at end changing any left brackets
	      (goto-char end)
	      (while 
		  (progn
		    (insert ?\))
		    (save-excursion
		      (condition-case ()
			  (progn (backward-sexp)
				 (if (= (char-after (point)) ?\[)
				     (progn
				       (delete-char 1)
				       (insert ?\()
				       (backward-char)))
				 (> (point) begin))
			(error (delete-backward-char 1)
			       nil))))))))))))


(defun install-lisp-superbracket ()
  ;; Install the lisp superbracket for the current mode.
  (let ((stab (syntax-table))
	(map (current-local-map)))
    (if (eq stab (standard-syntax-table))
	(error "Won't clobber default syntax table"))
    (if (null map)
	(error "No local keymap?"))
    (modify-syntax-entry ?\[ "(]" stab)
    (modify-syntax-entry ?\[ "(]" stab)
    (define-key map "]" 'lisp-superbracket)))
  
