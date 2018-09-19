(require 'thingatpt+)
	

;; highlight some keywords
(font-lock-add-keywords 'ruby-mode
'(("\\<\\(FIXME\\|HACK\\|XXX\\|FLUNK\\|TODO\\|ToDo\\)" 1 font-lock-warning-face prepend)))


;; ;; (setq load-path (cons "~/Dropbox/home/dot.emacs.d" load-path))
;;(require 'rvm)
;; (rvm-use-default) ;; use rvm's default ruby for the current Emacs session

;; regenerating documentation for the current buffer, eg:
;; % rdoc -r app/models/account.rb
(defun regenerate-ruby-docs ()
  ""
	  (interactive)				;this makes the function a  command too
	(let* ((filezname  (buffer-file-name (current-buffer))))
	 (shell-command (concat "echo 'rdoc -r " filezname " ' | bash --login" ))))



; ri fast ruby docs , obsolete : https://github.com/pedz/ri-emacs
;; (setq ri-ruby-script "~/Dropbox/home/dot.emacs.d/plugins/ri-emacs.rb")
;; (autoload 'ri "~/home/dot.emacs.d/plugins/ri-ruby.el" nil t);;
;; ;;  (load-file "~/Dropbox/home/dot.emacs.d/plugins/ri-ruby.el")
;;
;;(defun create-tags (dir-name) "Create tags file." (interactive "DDirectory: ") (eshell-command (format "find %s -type f -name \"*.[rb]\" | xargs etags -o -append" dir-name)))
;;     M-.       goes to the symbol definition
;;     M-0 M-.   goes to the next matching definition
;;     M-*       return to your starting point
;; One pretty annoying thing about ctags is that it only indexes declarations and definitions of symbols, not invocations. Fortunately emacs has a built-in workaround for this, called "tags-search". This is basically a grep that looks through all the source files mentioned in your TAGS file. It's fast, so you can pretty quickly zip through all the matches in your cbase:

;;     M-x tags-search <type your regexp>       initiate a search
;;     M-,                                      go to the next match


;;  add the following to your init.el, replacing the filenames with
;;  their correct locations:
;;
;;  (setq ri-ruby-script "~/Dropbox/home/dot.emacs.d/plugins/ri-emacs.rb")
;;  (autoload 'ri "~/Dropbox/home/dot.emacs.d/plugins/ri-ruby.el" nil t)
;;
;;  You may want to bind the ri command to a key.
;;  For example to bind it to F1 in ruby-mode:
;;  Method/class completion is also available.
;;
  ;; (add-hook 'ruby-mode-hook (lambda ()
  ;;                             (local-set-key 'f1 'ri)
  ;;                             (local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)
  ;;                             (local-set-key 'f4 'ri-ruby-show-args)
  ;;                             ))


;; (mapc (lambda (func)
;; (autoload func "ri-ruby" nil t))
;; '(ri ri-ruby-complete-symbol ri-ruby-show-args))

;; ;; this only works if ri-emacs can be found in your PATH
;; (setq ri-ruby-script (locate-file "ri-emacs" exec-path))

;; ;; (add-hook 'ruby-mode-hook	
;; ;; 	(lambda ()	
;; ;; 	(local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)	
;; ;; 	(local-set-key (kbd "<f4>") 'ri-ruby-show-args)))

;; (global-set-key "\C-cs" 'ri-ruby-complete-symbol)
;; (global-set-key "\C-ca" 'ri-ruby-show-args)

;; 2015 sept - yari seems broken too. old.
;; (require 'yari)
;; (defun ri-bind-key ()
;;   (local-set-key [f1] 'yari))

(add-hook 'ruby-mode-hook
	  (lambda ()
	    (autopair-mode)))

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))


;; toggle this, first 2 are rails style, 2nd 2 oz style

;;(setq ruby-indent-level 2) ;
;;(setq ruby-indent-tabs-mode t)
;;(setq ruby-indent-level 8)

;;(add-hook 'ruby-mode-hook 'eldoc-mode)

;; some hard sets for emacs 25 good ruby behavior


(setq ruby-indent-tabs-mode t)
(setq-default indent-tabs-mode t)
(setq enh-ruby-indent-tabs-mode t)
(setq electric-indent-mode nil)
(global-set-key (kbd "RET") 'newline-and-indent)



(defun flip_ruby ()
  "flip ruby"
	  (interactive)				;this makes the function a  command too
	(if (string-match "_spec" (buffer-file-name (current-buffer)))
				(find-file (string-replace-2 "/spec"  "/app" (string-replace-2 "_spec.rb" ".rb"(buffer-file-name (current-buffer)))))
				(find-file (string-replace-2 "/app"  "/spec" (string-replace-2 ".rb" "_spec.rb"(buffer-file-name (current-buffer))))))
	)
(global-set-key [(control c) ?f] 'flip_ruby);; pending using a better offiical one

;; ruby mode, test flip  go to test mode
(global-set-key (kbd "\C-ct") 'flip_ruby)

;; go to the model 
(defun model_ruby ()
  "opening-dot-emacs"
	  (interactive)				;this makes the function a  command too
	  (find-file (string-replace-2 "/controllers"  "/models" (string-replace-2 "s.rb" ".rb"(buffer-file-name (current-buffer)))))
	)
(global-set-key (kbd "\C-cm") 'model_ruby)

;; go to the controller
(defun controller_ruby ()
  "opening-dot-emacs"
	  (interactive)				;this makes the function a  command too
	  (find-file (string-replace-2 "/models"  "/controllers" (string-replace-2 ".rb" "s.rb"(buffer-file-name (current-buffer)))))
	)
(global-set-key (kbd "\C-cc") 'controller_ruby)

(defun my-ri-lookup()
  (interactive)
  (let* ((default (region-or-word-at-point))
	 (term (read-string (format "Ruby docs for (%s): "      default) default)))
    (let ((term (if (zerop(length term)) default term)))
    (shell-command (concat "echo 'ri -f ansi " term  " ' | bash --login" )))))


;; to use, insertion point should be right after the function or Classname name, then do this:
;; result page should show up in your default browser
(global-set-key (kbd "C-c i") 'my-ri-lookup)

(global-set-key (kbd "C-c o") 'regenerate-ruby-docs)

;;(require 'inf-ruby);; creates a new function (run-ruby)
;; (add-to-list 'auto-mode-alist '("\\.rb\\'" . flycheck-mode))

;; run test on line
(defun run-test-on-line (&optional flags)
  "run rspec test on the given line"
  (interactive)
  (let (
;; ;;	(default-directory "~/Dropbox/home/oz/oz_app4/oz_app/")
	)
	(setq this_file (buffer-file-name))
	(setq this_line_number (substring (what-line) 5))  ;; cut off 	"Line "

    (grep (concat "echo 'bundle exec rspec --drb  " buffer-file-name ":" this_line_number " | sed \"s/[      #]*//g\"' | bash --login" ))))
;;    (grep (concat "echo 'bundle exec rspec --drb  " buffer-file-name  " | sed \"s/[      #]*//g\"' | bash --login" ))))
;; press control-c g to google the selected region
(global-set-key (kbd "C-c t") 'run-test-on-line)
