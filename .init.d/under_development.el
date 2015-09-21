;; (setq inferior-lisp-program "java -cp /opt/local/share/java/clojure/lib/clojure.jar clojure.main")
;;(setq inferior-lisp-program "java -cp ~/home/src/clojure/clojure/clojure-1.2.0-master-SNAPSHOT.jar clojure.main")

(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(add-hook 'slime-mode-hook
          (lambda ()
            (setq slime-truncate-lines nil)
            (slime-redirect-inferior-output)))


;; rich hickey

;; (setq swank-clojure-jar-path "~/home/src/clojuret/clojure/clojure-1.2.0-master-SNAPSHOT.jar")

;; (require 'clojure-mode)
;;  (load-file "~/home/src/clojure/clojure/swank-clojure/swank-clojure.el")
;; (require 'swank-clojure-autoload)
;; (require 'slime)

;; (eval-after-load "slime" (slime-setup '(slime-repl)))
;; (slime-setup)

(defun java-mode-setup ()
;;  (c-set-style "java")
;;  (define-key java-mode-map (kbd "RET") 'c-newline-and-perhaps-comment)
;;  (setq comment-line-break-function 'c-newline-and-perhaps-comment)
;;  (turn-on-auto-fill)
;;  (setq fill-column 76)
;;  (define-key java-mode-map (kbd "C-c S") 'c-insert-seperating-comment)
;;  (define-key java-mode-map (kbd "C-c L") 'c-insert-line-comment)
;;  (c-set-offset 'func-decl-cont '++)
;;  (setq c-tab-always-indent nil)
)

;; ;;(defun a-java-mode-hook ()
;; ;; ;;  (setq tab-width 4)
;; ;;  (setq-default c-basic-offset 4)
;)

;;(add-hook 'java-mode-hook 'a-java-mode-hook)


;;{{{ make-perl-script

(defun make-perl-script (arg)
  "Make the current buffer into a perl script.
With arg, nukes first."
  (interactive "*P")
  (cond
   ((or arg (= (- (point-min) (point-max)) 0))
    (erase-buffer)
    (insert-file "~/bin/debug.pl")))
  (save-excursion
    (shell-command (concat "chmod +x "
			   (buffer-file-name))))
  (if (search-forward "gud-perldb-history: " nil
		      t)
      (insert (concat "(\"perl "
                      (file-name-nondirectory
		       (buffer-file-name))
                      "\")")))
  (save-buffer)
  (shell-command (concat "chmod a+x "
			 (buffer-file-name)))
  (find-alternate-file (buffer-file-name)) ;; set  mode, fontification, etc.
  (beginning-of-buffer)
  (search-forward "usage=\"Usage: $0 \[-$flags\]"
		  nil t))




;; (setq shell-mode-hook 'my-shell-setup)

;; ;; #########################3
;; (defun my-shell-setup ()
;;   "For bash (cygwin 18) under Emacs 20"
;;   (setq comint-scroll-show-maximum-output 'this)
;;   (setq comint-completion-addsuffix t)
;;   ;; (setq comint-process-echoes t) ;; reported   that this is no longer needed
;;   (setq comint-eol-on-send t)
;;   (make-variable-buffer-local
;;    'comint-completion-addsuffix))


;; ---------------------------------------------------------------------------
;; activate Python mode 
;; available at: http://www.python.org/emacs/python-mode/
;; ---------------------------------------------------------------------------
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
