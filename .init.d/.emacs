;; -*-mode:Emacs-Lisp-*-
;; Time-stamp: <2004-03-24 13:38:41
;;-----------------------------------------------------------------------------
;; Author    : Dan Miley
;; File      : DOT Emacs file.
;;             
;; Note      : Do not byte-compile the .emacs file. If you do, the saving
;;             of customisation thru Emacs will get saved in .emacs.elc
;;             and you would not want that!!
;; Status    :
;;           o 
;;           o TO DO : add the JDE java major dev mode at http://jdee.sunsite.dk/
;;             Pcl-cvs - The Emacs Front-End to CVS
;;           o AspectJ for Emacs v1.1b2: supports AspectJ 1.1, GNU
;;           Emacs 20.7, XEmacs 21.4.3 and JDEE
;;           jdee.sunsite.dk/rootpage.html  = java dev environment
;;-----------------------------------------------------------------------------


;; load to enable faultless and direct read and save in encrpted format gz
;; ;; (ignore-errors
;; ;;  (load-file "/usr/local/Cellar/emacs/24.3/share/emacs/24.3/lisp/jka-compr.elc")
;; ;;  (load-file "/usr/local/Cellar/emacs/24.5/share/emacs/24.5/lisp/jka-compr.elc")
;; ;;  )

 (ignore-errors
  (load-file "~/dot.emacs/.init.d/bash_shell.el")
 )

(require 'package) ;; You might already have this line

(setq package-list '(autopair yaml-mode org-mode yasnippet magit color-theme color-theme-sanityinc-solarized flycheck rinari thingatpt thingatpt+))

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib

 (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize) ;; You might already have this line

;; list the packages you want

(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; activate installed packages
(package-initialize)

(require 'cl)
(defun bk-kill-buffers (regexp)
  "Kill buffers matching REGEXP without asking for confirmation."
  (interactive "sKill buffers matching this regular expression: ")
  (flet ((kill-buffer-ask (buffer) (save-buffer buffer) (kill-buffer buffer)))
;;  (flet ((kill-buffer-ask (buffer)  (kill-buffer buffer)))
    (kill-matching-buffers regexp)))

(define-minor-mode sensitive-mode
  "For sensitive files like password lists.
It disables backup creation and auto saving.

With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode."
  ;; The initial value.
  nil
  ;; The indicator for the mode line.
  " Sensitive"
  ;; The minor mode bindings.
  nil
  (if (symbol-value sensitive-mode)
      (progn
	;; disable backups
	(set (make-local-variable 'backup-inhibited) t)	
	;; disable auto-save
	(if auto-save-default
	    (auto-save-mode -1)))
    ;resort to default value of backup-inhibited
    (kill-local-variable 'backup-inhibited)
    ;resort to default auto save setting
    (if auto-save-default
	(auto-save-mode 1))))

;; Once the above snippet has been evaluated in Emacs, M-x sensitive will disable backups and auto-save in the current buffer. All other buffers will continue to have these features.

;;I usually set sensitive mode to turn on by default for files having the gpg extension. The following code when put in your .emacs does exactly that:

;;(setq auto-mode-alist
;; (append '(("\\.gpg$" . sensitive-mode))
;;               auto-mode-alist))
;;(add-to-list 'auto-mode-alist '("\\.gpg$" . sensitive-mode))
(add-to-list 'auto-mode-alist '("\\.gpg\\'" . sensitive-mode))



;; password files should only be around 5 min or less; 1 hr max
;; (eval-expression (quote (run-at-time "5 min" 300 (quote (lambda nil (kill-buffer "home.gpg"))))) nil)
(run-at-time "60 min" (* 60 60) (quote (lambda nil (bk-kill-buffers ".*.gpg"))))

;; [~] ➔ brew install gpg  # do this first
(require 'epa-file)
;; (epa-file-enable)


;; (load-file "~/home/dot.emacs.d/elpa/yaml-mode-0.0.5/yaml-mode.el")
;; FIX THIS , SHOULDNT NEED A LOAD PATH
;; ;; (setq load-path (cons "~/Dropbox/home/dot.emacs.d/elpa/yaml-mode-0.0.5" load-path))
;; ;; (require 'yaml-mode)
;; ;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; ;; (setq load-path (cons "~/Dropbox/home/dot.emacs.d" load-path))
;;(require 'rvm)
;; (rvm-use-default) ;; use rvm's default ruby for the current Emacs session


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


;;  this way shell-commands will show ansi-color, elg.
;; (shell-command "echo 'ri -f ansi Account' | bash --login " nil nil)

(require 'ansi-color)

(defadvice display-message-or-buffer (before ansi-color activate)
  "Process ANSI color codes in shell output."
  (let ((buf (ad-get-arg 0)))
    (and (bufferp buf)
         (string= (buffer-name buf) "*Shell Command Output*")
         (with-current-buffer buf
           (ansi-color-apply-on-region (point-min) (point-max))))))

;; 
(defun my-ri-lookup()

  (interactive)
  (let* ((default (region-or-word-at-point))
	 (term (read-string (format "Ruby docs for (%s): "      default) default)))
    (let ((term (if (zerop(length term)) default term)))
    (shell-command (concat "echo 'ri -f ansi " term  " ' | bash --login" )))))

;; Account validate_settings
;; to use, insertion point should be right after the function or Classname name, then do this:
;; result page should show up in your default browser
(global-set-key (kbd "C-c i") 'my-ri-lookup)

;; nice to see the looked up def in another window
(global-set-key  [(meta .)] 'find-tag-other-window)

;; regenerating documentation for the current buffer, eg:
;; % rdoc -r app/models/account.rb
(defun regenerate-ruby-docs ()
  ""
	  (interactive)				;this makes the function a  command too
	(let* ((filezname  (buffer-file-name (current-buffer))))
	 (shell-command (concat "echo 'rdoc -r " filezname " ' | bash --login" ))))

(defun open-finder-here ()
  "current buffers directory opened in macos finder"
	  (interactive)
	 (shell-command (concat "open . "  )))
(global-set-key "\C-x\C-o" 'open-finder-here)



(global-set-key (kbd "C-c o") 'regenerate-ruby-docs)

;; trial
(setq explicit-bash-args (list "--login" "--init-file" "/Users/dan/.profile" "-i"))

(setq path "/opt/local/bin:/opt/local/sbin:/Users/dan/bin:/usr/local/git/bin/git:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:/Users/dan/.rvm/gems/ruby-1.9.2-p320/bin:/Users/dan/.rvm/gems/ruby-1.9.2-p320@global/bin:/Users/dan/.rvm/rubies/ruby-1.9.2-p320/bin:/Users/dan/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin/git:/usr/local/git/bin:/Users/dan/bin:/usr/X11/bin:/usr/local/mysql/bin:/Applications/MacPorts/Emacs.app/Contents/MacOS/bin:/Applications/MacPorts/Emacs.app/Contents/MacOS:/opt/local/var/scala/bin:/usr/local/mysql/bin:/opt/local/var/scala/bin:/Users/dan/.rvm/bin")
(setenv "PATH" path)

;; (defun set-exec-path-from-shell-PATH ()
;;   (let ((path-from-shell 
;;       (replace-regexp-in-string "[[:space:]\n]*$" "" 
;;         (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))
;; (when (equal system-type 'darwin) (set-exec-path-from-shell-PATH))


;; easier to do meta-x
(global-set-key "\C-x\C-m" 'execute-extended-command)

;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;; '(flymake-errline ((((class color)) (:background "LightPink" :foreground "black")))) 
;; '(flymake-warnline ((((class color)) (:background "LightBlue2" :foreground "black")))) 
;; )

(defun un-camelcase-string ()
  (interactive)
      "Convert CamelCase string S to lower case with word separator SEP.
    Default for SEP is a hyphen \"-\".
    If third argument START is non-nil, convert words after that
    index in STRING."
      (let ((case-fold-search nil)(sep "_")(start 1)(s (region-or-word-at-point)))
        (while (string-match "[A-Z]" s (or start 1))
          (setq s (replace-match (concat (or sep "-") 
                                                 (downcase (match-string 0 s))) 
                                         t nil s)))
	(insert        (downcase s))
	(kill-word 1)
	))

;; ;; ido - rinari likes this
(require 'ido)
(ido-mode t);; but ido is hard to use, needs review

(setq inhibit-splash-screen t) ;; no splash screen
;; (set-fringe-mode 3) ;; ou can put the following in your .emacs file to control the size of the fringe on the left and right:


(progn
  (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))  ;; no toolbar
  (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))  ;; no toolbar
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))  ;; no toolbar
  )

;; (setq load-path (cons "~/home/dot.emacs.d/org-7.3/lisp" load-path))
;; (setq load-path (cons "~/home/dot.emacs.d/org-7.3/contrib/lisp" load-path))
;; (require 'org-install)

;; (setq org-directory "~/home/dot.emacs.d/org-7.3")

;; ;; (setq load-path (cons "~/Dropbox/home/dot.emacs.d/org-mode/lisp" load-path))
;; ;; (setq load-path (cons "~/Dropbox/home/dot.emacs.d/org-mode/contrib/lisp" load-path))
;; (require 'org-install)

;; ;; (setq org-directory "~/Dropbox/home/dot.emacs.d/org-mode")

;; ;; (require 'ox-confluence)

;;(load-file "~/home/dot.emacs.d/p4.el")

;; Set to the location of your Org files on your local system
;; ;; (setq org-directory "~/Dropbox/home/org")
;; ;; ;; Set to the name of the file where new notes will be stored
;; ;; (setq org-mobile-inbox-for-pull "~/Dropbox/home/org/flagged.org")
;; ;; ;; Set to <your Dropbox root directory>/MobileOrg.
;; ;; (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")



(setq org-todo-keywords (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
 (sequence "WAITING(w@/!)" "SOMEDAY(s!)" "|" "CANCELLED(c@/!)")
 (sequence "QUOTE(q!)" "QUOTED(Q!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
 (sequence "OPEN(O)" "|" "CLOSED(C)"))))

(setq org-todo-keyword-faces (quote (("TODO" :foreground "red" :weight bold)
 ("NEXT" :foreground "blue" :weight bold)
 ("DONE" :foreground "forest green" :weight bold)
 ("WAITING" :foreground "yellow" :weight bold)
 ("SOMEDAY" :foreground "goldenrod" :weight bold)
 ("CANCELLED" :foreground "orangered" :weight bold)
 ("QUOTE" :foreground "hotpink" :weight bold)
 ("QUOTED" :foreground "indianred1" :weight bold)
 ("APPROVED" :foreground "forest green" :weight bold)
 ("EXPIRED" :foreground "olivedrab1" :weight bold)
 ("REJECTED" :foreground "olivedrab" :weight bold)
 ("OPEN" :foreground "magenta" :weight bold)
 ("CLOSED" :foreground "forest green" :weight bold))))

; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ("@errand" . ?e)
                            ("@office" . ?o)
                            ("@home" . ?h)
                            ("@farm" . ?f)
                            (:endgroup)
                            ("PHONE" . ?P)
                            ("QUOTE" . ?q)
                            ("WAITING" . ?w)
                            ("FARM" . ?F)
                            ("HOME" . ?H)
                            ("ORG" . ?O)
                            ("NORANG" . ?N)
                            ("crypt" . ?c)
                            ("MARK" . ?M)
                            ("NOTE" . ?n)
                            ("CANCELLED" . ?C))))

; Allow setting single tags without the menu
(setq org-fast-tag-selection-single-key (quote expert))

;; auto-revert-mode  - if you tailling a file, this is handy

;; ;; (load-file "~/Dropbox/home/dot.emacs.d/thingatpt.el")
;; ;; (load-file "~/Dropbox/home/dot.emacs.d/thingatpt+.el")

(add-hook 'c-mode-common-hook


(lambda ()(setq c-hungry-delete-key t)))
;; enable global nungry delete
(require 'cc-mode)    
;;(global-set-key (kbd "C-d") 'c-hungry-delete-forward)
;;(global-set-key (kbd "DEL") 'c-hungry-delete-forward)
;;(global-set-key (kbd "<backspace>") 'c-hungry-delete-backwards)

;; (normal-erase-is-backspace-mode 1)

;; (define-key function-key-map [delete] [deletechar])



;; towards a perfect ruby doc finder:
(defun ruby-oo()

  (interactive)
  (let* ((default (region-or-word-at-point))
	 (term (read-string (format "Ruby doc lookup for this (%s): "      default) default)))
    (let ((term (if (zerop(length term)) default term)))
      (browse-url (format "http://www.google.com/webhp#q=%s+site:ruby-doc.org&btnI" term)))))

;; to use, insertion point should be right after the function or Classname name, then do this:
;; result page should show up in your default browser
(global-set-key (kbd "C-c r") 'ruby-oo)
;; eg, try it on this line:
;; Hash

(defun maximize-frame ()
  (interactive)
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 1000 1000))

;; doesnt work well with comand line emacs
;; (global-set-key "\C-cm" 'maximize-frame)

(defun minimize-frame () 
  (interactive)
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 80 40))

(global-set-key "\C-cn" 'minimize-frame)

 (setq ns-pop-up-frames nil) ;; this prevents extrnal apps like p4 or
;; emacsclient from popping new frames

;; google-region
(defun google-region (&optional flags)
  "Google the selected region"
  (interactive)
  (let ((query (buffer-substring (region-beginning) (region-end))))
    (browse-url (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=" query))))
;; press control-c g to google the selected region
(global-set-key (kbd "C-c g") 'google-region)
;; google-region


(auto-fill-mode nil)

;; Org-mode settings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-c." 'org-do-promote)
(global-set-key "\C-c<" 'org-demote)
(global-font-lock-mode 1)

(defun my-org-mode-startup ()
  "Setup org mode so its useful."
  (setq org-log-done t)
  (setq org-odd-levels-only t)
  (setq org-hide-leading-stars t))

(add-hook 'org-mode-hook 'my-org-mode-startup)


;; this  doesnt work for me, (select deletes on type)
;; (delete-selection-mode nil)

;; loading for mac only

;;  Add in my paths
;; (when (equal system-type 'darwin)
	;; (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
	;; (push "/opt/local/bin" exec-path))

 
;; opacity / transparency

;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))

;; You can use the following snippet after you’ve set the alpha as above to assign a toggle to “C-c t”:

(global-hl-line-mode 1) ;; cur line hilite



;; ;;    (load-file "~/Dropbox/home/dot.emacs.d/plugins/ibuffer-git/ibuffer-git.el")
  ;; (require 'ibuffer-git)

     (global-set-key (kbd "C-x C-b") 'ibuffer)
;;     (autoload 'ibuffer "ibuffer" "List buffers." t)


(setq ibuffer-formats '((mark modified read-only " " (name 16 16) " "
                        (size 6 -1 :right) " " (mode 16 16 :center)
                         " " (process 8 -1) " " filename)
                    	   (mark " " (name 16 -1) " " filename))
      ibuffer-elide-long-columns t
      ibuffer-eliding-string "&")

;; (custom-set-variables
;;  '(ibuffer-expert t)
;;  '(ibuffer-git-column-length 8)
;;  '(ibuffer-fontification-alist (quote ((10 buffer-read-only font-lock-constant-face) (15 (and buffer-file-name (string-match ibuffer-compressed-file-name-regexp buffer-file-name)) font-lock-doc-face) (20 (string-match "^*" (buffer-name)) font-lock-keyword-face) (25 (and (string-match "^ " (buffer-name)) (null buffer-file-name)) italic) (30 (memq major-mode ibuffer-help-buffer-modes) font-lock-comment-face) (35 (eq major-mode (quote dired-mode)) font-lock-function-name-face) (1 (eq major-mode (quote cperl-mode)) cperl-hash-face) (1 (eq major-mode (quote rcirc-mode)) rcirc-server))))
;;  '(ibuffer-formats (quote ((mark modified read-only git-status-mini " " (name 18 18 :left :elide) " " (size 9 -1 :right) " " (mode 16 16 :left :elide) " " (eprojkect 16 16 :left :elide) " " (git-status 8 8 :left) " " filename-and-process) (mark " " (name 16 -1) " " filename))))
;;  '(ibuffer-git-column-length 8)
;; )


;; Here are the keys in the minor mode.

;; TAB       -- execute normal TAB command, if point doesn't move, try to
;;              toggle the visibility of the block.
;; <S-tab>   -- execute normal <S-tab command, if point doesn't move, try to
;;              toggle the visibility of all the blocks.
;; ;; (add-to-list 'load-path "~/Dropbox/home/dot.emacs.d/plugins/hideshow-org")
;; ;; (require 'hideshow-org)
;; ;; (global-set-key "\C-ch" 'hs-org/minor-mode)


;; allows use of alt arrow keys to navigate arround the buffer windows
(require 'windmove)
(windmove-default-keybindings 'meta)

;; able to toggle line numbers on and off
(autoload 'linum-mode "linum" "toggle line numbers on/off" t) 
(global-set-key (kbd "\C-cl") 'linum-mode)    

;; highlight some keywords
(font-lock-add-keywords 'ruby-mode
'(("\\<\\(FIXME\\|HACK\\|XXX\\|FLUNK\\|TODO\\|ToDo\\)" 1 font-lock-warning-face prepend)))


;;(load-file "~/home/dot.emacs.d/flycheck-master/flycheck.el")
;; Let's run 8 checks at once instead.

;; ;; flymake defaults to ruby 1.8.7, this is a hardcoded way to get it
;; ;; to go over to 1.9 ruby syntax
;; (load-file "~/home/dot.emacs.d/plugins/flymake-ruby.el")
;; (if (file-exists-p "/Users/dan/.rvm/rubies/ruby-1.9.2-p290/bin/ruby")
;;     (setq flymake-ruby-command-name "/Users/dan/.rvm/rubies/ruby-1.9.2-p290/bin/ruby")
;;   (setq flymake-ruby-command-name "ruby"))

;;   (require 'flymake-ruby)
;;   (add-hook 'ruby-mode-hook
;;           '(lambda ()
;; 	     ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
;; 	     (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
;; 		 (flymake-ruby-load))
;; 	     ))


;; (defun flymake-ruby-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     ;; Invoke ruby with '-c' to get syntax checking
;;     (list flymake-ruby-command-name (list "-c" local-file))))



	;;	 live syntax error checking
;; I don't like the default colors :)
;;(set-face-background 'flymake-errline "red43")
;;(set-face-background 'flymake-warnline "dark slate blue")


; ri fast ruby docs
;; ;;  (setq ri-ruby-script "~/Dropbox/home/dot.emacs.d/plugins/ri-emacs.rb")
;; ;; ;; (autoload 'ri "~/home/dot.emacs.d/plugins/ri-ruby.el" nil t);;
;; ;;  (load-file "~/Dropbox/home/dot.emacs.d/plugins/ri-ruby.el")
;;
;;(defun create-tags (dir-name) "Create tags file." (interactive "DDirectory: ") (eshell-command (format "find %s -type f -name \"*.[rb]\" | xargs etags -o -append" dir-name)))
;;     M-.       goes to the symbol definition
;;     M-0 M-.   goes to the next matching definition
;;     M-*       return to your starting point
;; One pretty annoying thing about ctags is that it only indexes declarations and definitions of symbols, not invocations. Fortunately emacs has a built-in workaround for this, called "tags-search". This is basically a grep that looks through all the source files mentioned in your TAGS file. It's fast, so you can pretty quickly zip through all the matches in your cbase:

;;     M-x tags-search <type your regexp>       initiate a search
;;     M-,                                      go to the next match


(mapc (lambda (func)
(autoload func "ri-ruby" nil t))
'(ri ri-ruby-complete-symbol ri-ruby-show-args))

;; this only works if ri-emacs can be found in your PATH
(setq ri-ruby-script (locate-file "ri-emacs" exec-path))

;; (add-hook 'ruby-mode-hook	
;; 	(lambda ()	
;; 	(local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)	
;; 	(local-set-key (kbd "<f4>") 'ri-ruby-show-args)))

(global-set-key "\C-cs" 'ri-ruby-complete-symbol)
(global-set-key "\C-ca" 'ri-ruby-show-args)


;; cycle through buffers with Ctrl-Tab (like Chrome/Firefox)
(global-set-key (kbd "\C-cb") 'bury-buffer)
(global-set-key (kbd "\C-cf") 'next-buffer)

;; ;; (add-to-list 'load-path
;; ;;                   "~/Dropbox/home/dot.emacs.d/plugins/yasnippet-0.6.1c")
;; ;;     (require 'yasnippet) ;; not yasnippet-bundle
;; ;;     (yas/initialize)   ;; TODO
;; ;;     (yas/load-directory "~/Dropbox/home/dot.emacs.d/plugins/yasnippet-0.6.1c/snippets")
;;	(yas/load-directory "~/home/dot.emacs.d/plugins/yasnippet-0.6.1c/snippets/text-mode/ruby-mode/shoulda-mode")
;; might break if not installed! ugh

;; ;; dont attempt for terminal sessions
;; (if window-system 
;; 	(setq default-frame-alist '((font . "-apple-Terminus-medium-normal-normal-*-14-140-*-*-m-0-iso10646-1")))
;; )
;; (if (eq window-system 'x)
;; 	(setq default-frame-alist '((font . "-apple-Terminus-medium-normal-normal-*-14-140-*-*-m-0-iso10646-1")))
;; 	)


;;  typography stuff, widen line spacing
(setq-default line-spacing 1)


(savehist-mode 1)

(setq file-name-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(setq inferior-lisp-program "java -cp /opt/local/share/java/clojure/lib/clojure.jar clojure.main")
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


  ;;mode-compile
 ;; ;; (load-file "~/Dropbox/home/dot.emacs.d/mode-compile.el")
 ;; ;;    (autoload 'mode-compile "mode-compile"
 ;; ;;      "Command to compile current buffer file based on the major mode" t)
 ;; ;;    (global-set-key "\C-cc" 'mode-compile)
 ;; ;;    (autoload 'mode-compile-kill "mode-compile"
 ;; ;;      "Command to kill a compilation launched by mode-compile" t)
 ;; ;;    (global-set-key "\C-ck" 'mode-compile-kill)
		

;; textmate style pairing of braces and quotes
;; Opening braces/quotes are autopaired;
;; Closing braces/quotes are autoskipped;
;; Backspacing an opening brace/quote autodeletes its pair.
;; Newline between newly-opened brace pairs open an extra indented line.
;; Autopair works well across all Emacs major-modes, deduces from the language's syntax table which characters to pair, skip or delete. It should work even with extensions that redefine such keys
;; (load-file "~/Dropbox/home/dot.emacs.d/autopair.el")
;; (require 'autopair)
;;(autopair-global-mode) ;; enable autopair in all buffers 

;; only turn on the just for a few mods
   (defvar autopair-modes '(r-mode ruby-mode rspec-mode))
  (defun turn-on-autopair-mode () (autopair-mode 1))
  (dolist (mode autopair-modes) (add-hook (intern (concat (symbol-name mode) "-hook")) 'turn-on-autopair-mode))


;;(load-file "~/home/dot.emacs.d/rspec-mode/rspec-mode-bjorn.el")

;; ;;load the path etc
;; (load-file "~/Dropbox/home/dot.emacs.d/my-shell.el")


;; (load-file "~/Dropbox/home/dot.emacs.d/session.el")
;; (require 'session)
;; (add-hook 'after-init-hook 'session-initialize)

;;(add-hook 'after-init-hook 'color-theme-twilight)


;; shell-toggle.el stuff

;; (load-file "~/Dropbox/home/dot.emacs.d/shell-toggle.el")
;; (autoload 'shell-toggle "shell-toggle" 
;;   "Toggles between the *shell* buffer and whatever buffer you are editing." t) 

;; (global-set-key [f4] 'shell-toggle)

(shell)                       ;; start a shell
;; (rename-buffer "shell-first") ;; rename it
(rename-buffer "shell") ;; rename it

;;;;  improve shell history
(add-hook 'shell-mode-hook
	  '(lambda ()
             (local-set-key [home]        ; move to beginning of line, after prompt
                            'comint-bol)
	     (local-set-key [up]          ; cycle backward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-previous-input 1)
                                 (previous-line 1))))
	     (local-set-key [down]        ; cycle forward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-next-input 1)
                                 (forward-line 1))))
             ))

;; (require 'git)


;; end trial

(setq user-full-name "Dan Miley")
(setq user-mail-address "dan.miley@gmail.com")

(setq-default indent-tabs-mode t)

;; toggle this, first 2 are rails style, 2nd 2 oz style

;;(setq indent-tabs-mode t)
;;(setq ruby-indent-level 2) ;
(setq ruby-indent-tabs-mode t)
(setq ruby-indent-level 8)

;; javascript and JS
;;(autoload 'js2-mode "js2" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; (load-file "~/Dropbox/home/dot.emacs.d/json-mode.el")
;; (add-to-list 'auto-mode-alist '("\\.json$" . json-mode))


(global-set-key (kbd "TAB") 'self-insert-command)


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;; (when
;;     (load
;; ;;     (expand-file-name b"~/.emacs.d/elpa/package.el"))
;;      (expand-file-name "~/Dropbox/home/dot.emacs.d/elpa/package.el"))
;;   (package-initialize))


;; this minimizes emacs win, avoid
(global-set-key [(control z)]  nil)


 (load-theme (quote sanityinc-tomorrow-bright) nil nil)


;; only if in its own window (not in a term, run the color scheme

;; ;; (progn 
;; ;;       (load-file "~/Dropbox/home/dot.emacs.d/color-theme-6.6.0/color-theme.el")
;; ;;       (load-file "~/Dropbox/home/dot.emacs.d/color-theme-6.6.0/themes/color-theme-twilight.el")
;; ;;       (load-file "~/Dropbox/home/dot.emacs.d/color-theme-6.6.0/themes/color-theme-solarized.el")
;; ;;       (color-theme-initialize)
;; ;;       (setq color-theme-is-global t)
;; ;;       (color-theme-twilight)   ;; Emacs in own window
;; ;;     )

;; ;; (require 'color-theme)
;; ;; ;; Use color themes only in windowed modes.
;; ;; (defun my-color-theme-frame-init (frame)
;; ;;   (set-variable 'color-theme-is-global nil)
;; ;;   (select-frame frame)
;; ;;       (progn 
;; ;;       (load-file "~/Dropbox/home/dot.emacs.d/color-theme-6.6.0/color-theme.el")
;; ;;       (load-file "~/Dropbox/home/dot.emacs.d/color-theme-6.6.0/themes/color-theme-twilight.el")
;; ;;       (load-file "~/Dropbox/home/dot.emacs.d/color-theme-6.6.0/themes/color-theme-solarized.el")
;; ;; ;;      (load-file "~/Dropbox/home/dot.emacs.d/color-theme-6.6.0/themes/subtle-hacker-rainbow.el")
;; ;;       (color-theme-initialize)
;; ;;       (setq color-theme-is-global t)
;; ;;       (color-theme-twilight)   ;; Emacs in own window
;; ;; 	))

;; ;; (add-hook 'after-make-frame-functions 'my-color-theme-frame-init)

;; ;; ;; Must manually call `my-color-theme-frame-init' for the initial frame.
;; ;; (cond ((selected-frame)
;; ;;        (my-color-theme-frame-init (selected-frame))))



;;
;; And then (color-theme-twilight) to activate it.
;;

;;(load-file "~/dot.emacs.d/fixme.el")   ;; colors the tags used to indicate what should be fixed(load-file "~/dot.emacs.d/python-mode.el")
;;(load-file "~/dot.emacs.d/SteveAckermann.emacs")
;;(load-file "~/dot.emacs.d/superbracket.el") 
;;(load-file "~/dot.emacs.d/KilianAFoth.emacs")   ;; colors the tags used to indicate what should be fixed
;;(load-file "~/dot.emacs.d/python-mode.el") 
;;(load-file "~/dot.emacs.d/347_emacs_for_web_programmers.emacs")   ;;; this causes problems with dired, use with caustion


;; (load "~/dot.emacs.d/nxml-mode-20041004/rng-auto.el")

;; (load "~/Dropbox/home/dot.emacs.d/html-helper-mode.el")
;; (require 'html-helper-mode "html-helper-mode.el")
;; (setq auto-mode-alist
;;         (cons '("\\.\\(xml\\|xsl\\|xsdl\\|rng\\|xhtml\\|html\\)\\'" . nxml-mode)
;; 	      auto-mode-alist))

(setq auto-mode-alist
        (cons '("\\.\\(html\\\)\\'" . html-mode)
	      auto-mode-alist))

(setq auto-mode-alist
      (cons '("\\.html$" . html-mode) auto-mode-alist))

;; load actionscript mode
;;(load-file "~/dot.emacs.d/csharp-mode.el")  ;; phpmode
;;(load-file "~/dot.emacs.d/actionscript-mode.el")  ;; phpmode

;; jump to and from specific places
(autoload 'session-jump-to-last-change "session")
(global-set-key (kbd "C-x C-_") 'session-jump-to-last-change)
(global-set-key (kbd "C-A-/") 'session-jump-to-last-change)


(global-set-key [ (control x) ?/] 'point-to-register)
(global-set-key [ (control x) ?j] 'jump-to-register)

(global-set-key [ (control x) ?%] 'insert-register)
(global-set-key [ (control x) ?%] 'insert-register)
(global-set-key [ (control x) ?~] 'query-replace)


; Associate java-mode with the .as extension actionscript
(setq auto-mode-alist (append '(("\\.as$" . java-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.mxml$" . java-mode)) auto-mode-alist))


;; This removes unsightly ^M characters that would otherwise
;; appear in the output of java applications.
;;
(add-hook 'comint-output-filter-functions
	  'comint-strip-ctrl-m)

;; Set start-up directory with cygwin nomenclature 
;; (your configuration files _must_ be in this directory):
;;(setq startup-directory "C:/cygwin/home/Administrator/")

;; generic-x.el is a standard package with Emacs 21.  It contains some 
;; very neat little modes, such as a JavaScript mode (but said mode
;; is not yet as good as c-mode for JavaScript, for it does not 
;; recognize /*-style comments.
;; All modes supported by generic-x.el are automatically applied
;; unless overridden below (for example, JavaScript mode is overridden 
;; below).
;;(require 'generic-x)

;;(add-to-list 'generic-extras-enable-list 'javascript-generic-mode)

;; (setq auto-mode-alist
;;      (cons '("\\.js$" . javascript-generic-mode) auto-mode-alist))

; Indent c code four spaces

(setq c-basic-offset 4)

; Associate c-mode with the .js extension

;; (setq auto-mode-alist (append '(("\\.js$" . c-mode)) auto-mode-alist))

(defun open-dot-emacs ()
  "opening-dot-emacs"
  (interactive)				;this makes the function a  command too
  (find-file "~/dot.emacs/.init.d/.emacs")
  )


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

;; ---------------------------------------------------------------------------
;; top levels
;; ---------------------------------------------------------------------------
;;  grep shortcuts---------------------------------------------------------------------------
(defun string-replace-2 (this withthat in)
  "replace THIS with WITHTHAT' in the string IN"
  (with-temp-buffer
    (insert in)
    (goto-char (point-min))
    (while (search-forward this nil t)
      (replace-match withthat nil t))
    (buffer-substring (point-min) (point-max))))

(defun flip_ruby ()
  "opening-dot-emacs"
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


(global-set-key [(control x) ?,] 'next-error)
(global-set-key [(control x) ?.] 'previous-error)


;; And I'm too used to the uEmacs M-g binding to goto-line
(global-set-key [(meta g)] 'goto-line)

(global-set-key [(shift f9)] 'split-window-horizontally)
(global-set-key [(control \;)] 'comment-region)

(global-set-key [(control \c)(control \c)] 'comment-region)

(global-set-key [f1] 'eval-region)
(global-set-key [f2] 'open-dot-emacs)

(global-set-key [f3] 'shell) 
(global-set-key [f4] 'indent-region)

(global-set-key [f5] 'bury-buffer)


;; Make control+pageup/down scroll the other buffer (mac air control-fn-arrow keys)
(global-set-key [(control next)] 'scroll-other-window)
(global-set-key [(control prior)] 'scroll-other-window-down)

(global-set-key [f9] 'scroll-other-window)
(global-set-key [f10] 'scroll-other-window-down)


;; split windows should display different buffers


(global-set-key [(control x) \5] 'hsplit-window-switch-buffer)

;; #########################3  # from 347_web programmers

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


(setq process-coding-system-alist (cons '("bash" . raw-text-unix)
					process-coding-system-alist))
(if window-system
(cond ((fboundp 'global-font-lock-mode)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t))))

;; The above code uses the default faces for
;;decoration. If you would like to customize the
;;attributes of the faces, you can use the
;;following startup code to get started:


(cond ((fboundp 'global-font-lock-mode)
       ;; Customize face attributes
       (setq font-lock-face-attributes
             ;; Symbol-for-Face Foreground Background Bold Italic Underline
             '((font-lock-comment-face "DarkGreen")
               (font-lock-string-face "Sienna")
               (font-lock-keyword-face "RoyalBlue")
               (font-lock-function-name-face "Blue")
               (font-lock-variable-name-face "Brown")
               (font-lock-type-face "Brown")
;;               (font-lock-reference-face "Purple")
               ))
       ;; Load the font-lock package.
       (require 'font-lock)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)))

(transient-mark-mode t)
(show-paren-mode 1)

(setq kill-emacs-query-functions
      (cons (lambda () (yes-or-no-p "Really kill Emacs? "))
            kill-emacs-query-functions))

(load "comint")
(fset 'original-comint-exec-1
      (symbol-function 'comint-exec-1))
(defun comint-exec-1 (name buffer command
			   switches)
  (let ((binary-process-input t)
	(binary-process-output nil))
    (original-comint-exec-1 name buffer
			    command switches)))


;; WINDOWS SPECIFIC
;; To copy between Emacs and other apps, you may
;;need to use the appropriate Windows codepage as
;;your coding system. To do this, you need to set
;; up the codepage first: 0
;; (if (eq window-system 'w32)
;;     ((codepage-setup 1251)
;;      (set-selection-coding-system 'cp1251)
;;      )
;;  )




;;{{{ Script creation and debugging

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



;; selective yanking (see selective-yank below)
(global-set-key [(alt y)] 
  (function 
   (lambda () (interactive)
     (if (eq last-command 'selective-yank)
         (selective-yank-pop)
       (call-interactively 'selective-yank)))))

;; better buffer cycling
(global-set-key [(control return)]
'forward-buffer)
(global-set-key [(control shift return)] 
'backward-buffer)

(defun find-all-files (regexp)
  "Find multiple files in one command."
  (interactive "sFind files matching regexp (default all): ")
  (if (string= "" regexp) (setq regexp ""))
  (let ((dir (file-name-directory regexp))
        (nodir (file-name-nondirectory regexp)))
    (if dir (cd dir))
    (if (string= "" nodir) (setq nodir "."))
    (let ((files (directory-files "." t  nil nil))
          (errors 0))
      (while (not (null files))
        (let ((filename (car files)))
          (if (file-readable-p filename)
              (find-file-noselect filename)
            (setq errors (+ 1 errors)))
          (setq files (cdr files))))
      (if (> errors 0)
          (message (format "%d files were unreadable." errors))))))

;; Define an easy way to move up in a dired directory, 
;; To instantly view a file in the web browser (IE or whatever) (this needs a current directory argument to work better):
;; **NOTE: These bindings must be in a mode-hook, since dired isn't automatically
;; loaded on startup and so it's keymap is void until you go into dired. 
(add-hook `dired-mode-hook
  `(lambda ()
     (define-key dired-mode-map "\C-w" 'dired-up-directory)
     (define-key dired-mode-map "\C-b" 'browse-url)))

;; Display time in the mode line
;; Put this line last to prove (by the time in the mode line)
;; that the .emacs loaded without error to this point.
(setq display-time-day-and-date t )

  (display-time)
  (setq frame-title-format 
        '((multiple-frames ("%b   ") 
        ("" invocation-name "@" system-name))
        "    " 
        display-time-string))
  ;; Per default, the time and date goes into the mode line.
  ;; We want it in the header line, so lets remove it.
  (remove-hook 'global-mode-string 'display-time-string)


;; Insert function comment file template from ~/templates directory
(defun insert-function-comment ()
  "Insert function comment"
  (interactive)
  (insert-file-contents "~/dot.emacs.d/templates/function.cpp.emacs"))

(global-set-key [f6] 'insert-function-comment)

;; ################################################## fine!
;;(message (concat "Ready to run as of " 
;;                 (time-stamp-mon-dd-yyyy) ", " (time-stamp-hh:mm:ss)))

;; maximize the window for win 

;; page up and down already treated
(global-set-key [kp-home]  'beginning-of-buffer) ; [Home]
(global-set-key [home]     'beginning-of-buffer) ; [Home]
(global-set-key [kp-end]   'end-of-buffer)       ; [End]
(global-set-key [end]      'end-of-buffer)       ; [End]

;; File Finder

;;This extension to the powerful Emacs complete-word facility is the major time saver for the frequent Emacs user. It is used within the find-file function and makes it possible to enter a given directory in the minibuffer by just entering a predefined two- to four letter sequence followed by the space key. Three different paths are given in the example below. The list can however be extended indefinetly.

(defun geosoft-parse-minibuffer ()
  ;; Extension to the complete word facility of the minibuffer
  (interactive)
  (backward-char 4)
  (setq found t)
  (cond
     ; local directories
     ((looking-at ".src") (setq directory "c:/usr/dmiley/src/"))
     ((looking-at ".pul") (setq directory "c:/usr/dmiley/src/pulse/"))
     ((looking-at ".pxs") (setq directory "c:/usr/dmiley/src/pulse/main/clients/ria/thirdparty/PxScript/PxScript/"))
     (t (setq found nil)))
  (cond (found (beginning-of-line)
                (kill-line)
                (insert directory))
         (t     (forward-char 4)
                (minibuffer-complete))))

;;The function is made an extension to the minibuffer complete-word function by:

(define-key minibuffer-local-completion-map " " 'geosoft-parse-minibuffer) 


;; Navigator

;;For fast navigation within an Emacs buffer it is necessary to be able to move swiftly between words. The functions below change the default Emacs behavour on this point slightly, to make them a lot more usable.

;;Note the way that the underscore character is treated. This is convinient behaviour in programming. Other domains may have different requirements, and these functions should be easy to modify in this respect.

(defun geosoft-forward-word ()
   ;; Move one word forward. Leave the pointer at start of word
   ;; instead of emacs default end of word. Treat _ as part of word
   (interactive)
   (forward-char 1)
   (backward-word 1)
   (forward-word 2)
   (backward-word 1)
   (backward-char 1)
   (cond ((looking-at "_") (forward-char 1) (geosoft-forward-word))
         (t (forward-char 1))))

(defun geosoft-backward-word ()
   ;; Move one word backward. Leave the pointer at start of word
   ;; Treat _ as part of word
   (interactive)
   (backward-word 1)
   (backward-char 1)
   (cond ((looking-at "_") (geosoft-backward-word))
         (t (forward-char 1))))

;;Bind the functions to Ctrl-Left and Ctrl-Right with:

(global-set-key [C-right] 'geosoft-forward-word)
(global-set-key [C-left] 'geosoft-backward-word) 


;; move temporary files
(defvar user-temporary-file-directory
(concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
`(("." . ,user-temporary-file-directory)
(,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
(concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
`((".*" ,user-temporary-file-directory t)))


(defun uniq-region (beg end)
  "Remove duplicate lines, a` la Unix uniq.
   If tempted, you can just do <<C-x h C-u M-| uniq RET>> on Unix."
  (interactive "r")
  (let ((ref-line nil))
      (uniq beg end 
	       (lambda (line) (string= line ref-line)) 
	       (lambda (line) (setq ref-line line)))))

(defun uniq-remove-dup-lines (beg end)
  "Remove all duplicate lines wherever found in a file, rather than
   just contiguous lines."
  (interactive "r")
  (let ((lines '()))
    (uniq beg end 
	     (lambda (line) (assoc line lines)) 
	     (lambda (line) (add-to-list 'lines (cons line t))))))

(defun uniq (beg end test-line add-line)
  (save-excursion
    (narrow-to-region beg end)
    (goto-char (point-min))
    (while (not (eobp))
      (if (funcall test-line (thing-at-point 'line))
	  (kill-line 1)
	(progn
	  (funcall add-line (thing-at-point 'line))
	  (forward-line))))
    (widen)))


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

(setq c-tab-always-indent t)
(setq c-indent-level 4)
(setq c-continued-brace-offset 4)
(setq c-brace-offset -4)
(setq c-brace-imaginary-offset 0)
(setq c-argdecl-indent 4)
(setq c-label-offset -4)
(setq c-continued-statement-offset 4)
(setq c-continued-brace-offset  0)
(setq tab-width  4)

; git hooks
;; (require 'magit)
;; ;; (load-file "~/Dropbox/home/dot.emacs.d/magit/magit.el")  





;; emacs transparency


(eval-when-compile (require 'cl))


;; makes emacs see through or not
;; form of (%viewing %background)
(defun toggle-transparency ()
   (interactive)
   (if (/=
        (cadr (find 'alpha (frame-parameters nil) :key #'car))
        100)
       (set-frame-parameter nil 'alpha '(100 100))
     (set-frame-parameter nil 'alpha '(85 50))))
     (defun ec ()
       (interactive)
       (let ((inhibit-read-only t))
         (erase-buffer))
       (eshell-send-input))

(global-set-key (kbd "C-c t") 'toggle-transparency)


 ;; (defun toggle-transparency ()
 ;;   (interactive)
 ;;   (if (/=
 ;;        (cadr (find 'alpha (frame-parameters nil) :key #'car))
 ;;        100)
 ;;       (set-frame-parameter nil 'alpha '(100 100))
 ;;     (set-frame-parameter nil 'alpha '(85 40))))
 ;; 




;; default to some transparenncy
;; (set-frame-parameter (selected-frame) 'alpha '(85 50))
;; (add-to-list 'default-frame-alist '(alpha 85 50))
 (set-frame-parameter (selected-frame) 'alpha '(100 100))
 (add-to-list 'default-frame-alist '(alpha 100 100))

(set-face-background 'hl-line "#220") 
(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))

;;(set-face-background 'highlight-current-line-face "light yellow")
(set-face-background 'hl-line "#111") 

;;(require 'inf-ruby);; creates a new function (run-ruby)

;; redirect prompt string to google lucky
(defun gll-region (&optional flags)
  "Google the selected region"
  (interactive)
  (setq query (read-string "feeling lucky?: "))
  (browse-url (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=&btnI=I'm+Feeling+Lucky&aq=f&aqi=&aql=&oq=&gs_rfai=&q=" query)))

;; press control-c g to google the selected region
(global-set-key (kbd "C-c f") 'gll-region)



;; To convert a file that contains tabs and spaces to one that contains only spaces, use the untabify command: M-x untabify

;; NOTES
;; Browsing the URL of the current buffer
;; The command `browse-url-of-buffer' gets a browser to render the URL associated with the file in the current buffer. This is great when editing web-related pages. For example, when you are editing an HTML file, you can have it rendered in your favourite browser by typing `C-c C-v'. This is especially nice if you are using a browser within Emacs like w3 or w3m; then you can have your source in the top window of an Emacs frame, and the output in the bottom frame, and simply regenerate whenever you like without ever having to leave the source!

;; will load that to the end
;; ;; (server-mode)

;; allow for use of emacsclient
;; ;; (if window-system
;; ;;     (server-start)
;; ;; )


;;-----------------------------------------------------------------------------
;; END File      : DOT Emacs file.
;;-----------------------------------------------------------------------------

