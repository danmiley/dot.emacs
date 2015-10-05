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
;;           jdee.sunsite.dk/rootpage.html  = java dev environment
;;-----------------------------------------------------------------------------

;; http://mixandgo.com/blog/how-i-ve-convinced-emacs-to-dance-with-ruby
;; some good stuff for 2015
;; http://crypt.codemancers.com/posts/2013-09-26-setting-up-emacs-as-development-environment-on-osx/
;; http://aaronbedra.com/emacs.d/
;; https://justin.abrah.ms/dotfiles/emacs.html
;; http://reinvent.kinvey.com/h/i/26122732-emacs-fans-rejoice-datadog-mode-is-here
;; load to enable faultless and direct read and save in encrpted format gz
;; https://github.com/timotheosh/aws-el
;; https://codehunk.wordpress.com/2009/06/27/emacs-repo-for-ruby-webapps/
;; ;; (ignore-errors
;; ;;  (load-file "/usr/local/Cellar/emacs/24.3/share/emacs/24.3/lisp/jka-compr.elc")
;; ;;  (load-file "/usr/local/Cellar/emacs/24.5/share/emacs/24.5/lisp/jka-compr.elc")
;; ;;  )


(setq user-full-name "Dan Miley")
(setq user-mail-address "dan.miley@gmail.com")

(defalias 'yes-or-no-p 'y-or-n-p)

(setq undo-outer-limit 100000000)

(require 'package) ;; You might already have this line

(setq package-list '(autopair yaml-mode
			      ;;
			      org
			      ;;
			      color-theme color-theme-sanityinc-tomorrow  twilight
			      ;;
			      docker
			      docker-tramp
			      dockerfile-mode
			      ;;
			      flycheck
			      rinari
			       apples-mode
			      find-file-in-project
			      ;; compa
;;			      company
;;			      company-inf-ruby
			      rvm
			      
			      ;;
			      thingatpt ;; thingatpt+  (can't get + to work as an install, manual load for now)
			      session rspec-mode fixmee json-mode textmate eshell
			      xclip
			      ))


;; mac only packages
;;   dash-functional
;;   date-at-point
;; apples-mode

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
 (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize) ;; You might already have this line

;; list the packages you want

(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
 (ignore-errors
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
)

;; activate installed packages
(package-initialize)

(require 'cl)
(defun bk-kill-buffers (regexp)
  "Kill buffers matching REGEXP without asking for confirmation."
  (interactive "Kill buffers matching this regular expression: ")
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

;;(require 'epa)
;;  (setq epg-gpg-program "gpg")
;; yaml

(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; markdown

;; have a look here; http://aaronbedra.com/emacs.d/



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

;; nice to see the looked up def in another window
(global-set-key  [(meta .)] 'find-tag-other-window)


;; trial
(setq explicit-bash-args (list "--login" "--init-file" "/Users/dan/.profile" "-i"))

(setq path "/opt/local/bin:/opt/local/sbin:/Users/dan/bin:/usr/local/git/bin/git:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:/Users/dan/.rvm/gems/ruby-1.9.2-p320/bin:/Users/dan/.rvm/gems/ruby-1.9.2-p320@global/bin:/Users/dan/.rvm/rubies/ruby-1.9.2-p320/bin:/Users/dan/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin/git:/usr/local/git/bin:/Users/dan/bin:/usr/X11/bin:/usr/local/mysql/bin:/opt/local/var/scala/bin:/usr/local/mysql/bin:/opt/local/var/scala/bin:/Users/dan/.rvm/bin")
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
(ido-mode t) 
(setq ido-enable-flex-matching t)
(add-to-list 'ido-ignore-files "\\.pyc")

;
(setq inhibit-splash-screen t) ;; no splash screen
;; (set-fringe-mode 3) ;; ou can put the following in your .emacs file to control the size of the fringe on the left and right:


(progn
  (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))  ;; no toolbar
  (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))  ;; no toolbar
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))  ;; no toolbar
  )

;; One use of Auto-Revert mode is to “tail” a file such as a system log, so that changes made to that file by other programs are continuously displayed. To do this, just move the point to the end of the buffer, and it will stay there as the file contents change. However, if you are sure that the file will only change by growing at the end, use Auto-Revert Tail mode instead (auto-revert-tail-mode). It is more efficient for this. Auto-Revert Tail mode works also for remote files.


;; auto-revert-mode  - if you tailling a file, this is handy

;; ;; (load-file "~/Dropbox/home/dot.emacs.d/thingatpt.el")
;; ;; (load-file "~/Dropbox/home/dot.emacs.d/thingatpt+.el")

(add-hook 'c-mode-common-hook
(lambda ()(setq c-hungry-delete-key t)))

;; enable global hungry delete
(require 'cc-mode)    
;;(global-set-key (kbd "C-d") 'c-hungry-delete-forward)
;;(global-set-key (kbd "DEL") 'c-hungry-delete-forward)
;;(global-set-key (kbd "<backspace>") 'c-hungry-delete-backwards)

;; (normal-erase-is-backspace-mode 1)

;; (define-key function-key-map [delete] [deletechar])

;; only to use with non term emacs
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


 (setq ns-pop-up-frames nil) ;; this prevents extrnal apps like p4 or  emacsclient from popping new frames

(auto-fill-mode nil)

;; this  doesnt work for me, (select deletes on type)
;; (delete-selection-mode nil)

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

;; allows use of alt arrow keys to navigate arround the buffer windows
(require 'windmove)
(windmove-default-keybindings 'meta)

;; able to toggle line numbers on and off
(autoload 'linum-mode "linum" "toggle line numbers on/off" t) 
(global-set-key (kbd "\C-cl") 'linum-mode)    

;; syntax checking

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

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


;; brew install aspell

(setq flyspell-issue-welcome-flag nil)
(if (eq system-type 'darwin)
    (setq-default ispell-program-name "/usr/local/bin/aspell")
  (setq-default ispell-program-name "/usr/bin/aspell"))
(setq-default ispell-list-command "list")

;;	 live syntax error checking
;; I don't like the default colors :)
;;(set-face-background 'flymake-errline "red43")
;;(set-face-background 'flymake-warnline "dark slate blue")


;; cycle through buffers with Ctrl-Tab (like Chrome/Firefox)
(global-set-key (kbd "\C-cb") 'bury-buffer)
(global-set-key (kbd "\C-cf") 'next-buffer)

;; tried but new snippet package didnt configure right, sticking to old setup for now. 
 (ignore-errors
(add-to-list 'load-path
                   "~/dot.emacs/.init.d/plugins/yasnippet-0.6.1c")
    (require 'yasnippet) ;; not yasnippet-bundle
    (yas/initialize)   ;; TODO
    (yas/load-directory "~/dot.emacs/.init.d/plugins/yasnippet-0.6.1c/snippets")
    (yas-global-mode 1))

;;As a workaround, you can redefine the Yasnippet expansion key instead, as explained in the FAQ:

;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

;; In this way, you use <C-tab> to expand Yasnippets and the TAB key for auto-complete-mode.

;; Note:

;; I also discovered that using <C-tab> to expand Yasnippets, instead of <tab>, had the advantage to make snippet expansion not interfer with indent-according-to-mode. For example: If I have a Lisp line: (ac-config-default) but it is not correctly indented, I usually press TAB to indent it correctly (using indent-according-to-mode). But if the cursor were between the a and c in (ac-config-default) it would instead have expanded the Lisp and-snippet (which is not desired here), to get the line ((and )c-config-default))..

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
(require 'autopair)

;; only turn on the just for a few mods
(defvar autopair-modes '(r-mode ruby-mode rspec-mode))
(defun turn-on-autopair-mode () (autopair-mode 1))
(dolist (mode autopair-modes) (add-hook (intern (concat (symbol-name mode) "-hook")) 'turn-on-autopair-mode))

;; sessions

(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;;(add-hook 'after-init-hook 'color-theme-twilight)


;; shell-toggle.el stuff

;; (load-file "~/Dropbox/home/dot.emacs.d/shell-toggle.el")
;; (autoload 'shell-toggle "shell-toggle" 
;;   "Toggles between the *shell* buffer and whatever buffer you are editing." t) 

;; (global-set-key [f4] 'shell-toggle)

;; (shell)                       ;; start a shell
;; (rename-buffer "shell-first") ;; rename it
;; (rename-buffer "shell") ;; rename it

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



;; end trial

(setq-default indent-tabs-mode t)

;; javascript and JS
;;(autoload 'js2-mode "js2" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; json

(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

(global-set-key (kbd "TAB") 'self-insert-command)


;; this minimizes emacs win, avoid
(global-set-key [(control z)]  nil)


(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

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

;; real deal for rails/padrino
;; ctags -e -R --extra=+fq --exclude=db --exclude=test --exclude=.git --exclude=public -f TAGS

;; this is ad'hoc excluded set to keep the TAGS file from gettin too big
(defun create-tags (dir-name) "Create tags file." (interactive "DDirectory: ") (eshell-command (format "ctags -e -R --extra=+fq --exclude=chef --exclude=vendor --exclude=scout --exclude=imagecore  --exclude=db --exclude=test --exclude=.git --exclude=public -f TAGS" dir-name)))
;;     M-.       goes to the symbol definition
;;     M-0 M-.   goes to the next matching definition
;;     M-*       return to your starting point
;; One pretty annoying thing about ctags is that it only indexes declarations and definitions of symbols, not invocations. Fortunately emacs has a built-in workaround for this, called "tags-search". This is basically a grep that looks through all the source files mentioned in your TAGS file. It's fast, so you can pretty quickly zip through all the matches in your cbase:

;; meta-return should comlpete the tag if it is unique
(global-set-key "\M-\r" 'complete-tag)

;;     M-x tags-search <type your regexp>       initiate a search
;;     M-,                                      go to the next match
(defun visit-tags (dir-name) "Create tags file." (interactive "DDirectory: ") (visit-tags-table(concat dir-name "TAGS" )))


(defun build-ctags (dir-name)
  (interactive)
  (message "building project tags")
  (let ((root (file-name-directory dir-name)))
    (shell-command (concat "ctags -e -R --extra=+fq --exclude=db --exclude=test --exclude=.git --exclude=public -f " root "TAGS " root)))
  (visit-project-tags)
  (message "tags built successfully"))

(defun visit-project-tags (dir-name)
  (interactive)
  (let ((tags-file (concat (eproject-root) "TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))


  ;;;  Auto refresh of the tags file

  ;;;  Jonas.Jarnestrom<at>ki.ericsson.se A smarter               
  ;;;  find-tag that automagically reruns etags when it cant find a               
  ;;;  requested item and then makes a new try to locate it.                      
  ;;;  Fri Mar 15 09:52:14 2002    

  ;; (defadvice find-tag (around refresh-etags activate)
  ;;  "Rerun etags and reload tags if tag not found and redo find-tag.              
  ;;  If buffer is modified, ask about save before running etags."
  ;; (let ((extension (file-name-extension (buffer-file-name))))
  ;;   (condition-case err
  ;;   ad-do-it
  ;;     (error (and (buffer-modified-p)
  ;;         (not (ding))
  ;;         (y-or-n-p "Buffer is modified, save it? ")
  ;;         (save-buffer))
  ;;        (er-refresh-etags extension)
  ;;        ad-do-it))))

  ;; (defun er-refresh-etags (&optional extension)
  ;; "Run etags on all peer files in current dir and reload them silently."
  ;; (interactive)
  ;; (shell-command (format "etags *.%s" (or extension ".rb")))
  ;; (let ((tags-revert-without-query t))  ; don't query, revert silently          
  ;;   (visit-tags-table default-directory nil)))
 


(setq path-to-ctags "/usr/local/bin/ctags")

;;  (defun create-tags (dir-name)
;;    "Create tags file."
;;    (interactive "DDirectory: ")
;;    (shell-command
;;     (format "find %s -name '*.mp4' | xargs %s -a -o %s/TAGS" dir-name '/usr/local/bin/etags' dir-name)))

;; (defun create-etags (dir-name)
;;   "Create tags file."
;;   (interactive "DDirectory: ")
;;   (eshell-command
;;    (format "find %sx -type f -name \"*.[ch]\" | etags -" dir-name)))


;; Prevent emacs from adding the encoding line at the top of the file
(setq ruby-insert-encoding-magic-comment nil)



;; html

(add-to-list 'auto-mode-alist '("\\.html\\'" . html-helper-mode))

(setq auto-mode-alist
        (cons '("\\.\\(html\\\)\\'" . html-mode)
	      auto-mode-alist))

(setq auto-mode-alist
      (cons '("\\.html$" . html-mode) auto-mode-alist))

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

;; http://emacswiki.org/emacs/GenericMode

;; generic-x.el is a standard package with Emacs 21.  It contains some 
;; very neat little modes, such as a JavaScript mode (but said mode
;; is not yet as good as c-mode for JavaScript, for it does not 
;; recognize /*-style comments.
;; All modes supported by generic-x.el are automatically applied
;; unless overridden below (for example, JavaScript mode is overridden 
;; below).
(require 'generic-x)


; Associate c-mode with the .js extension

;; (setq auto-mode-alist (append '(("\\.js$" . c-mode)) auto-mode-alist))

(defun open-dot-emacs ()
  "opening-dot-emacs"
  (interactive)				;this makes the function a  command too
  (find-file "~/dot.emacs/.init.d/.emacs")
  )
(global-set-key [f2] 'open-dot-emacs)


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



(global-set-key [(control x) ?,] 'next-error)
(global-set-key [(control x) ?.] 'previous-error)


;; And I'm too used to the uEmacs M-g binding to goto-line
(global-set-key [(meta g)] 'goto-line)

(global-set-key [(shift f9)] 'split-window-horizontally)
(global-set-key [(control \;)] 'comment-region)

(global-set-key [(control \c)(control \c)] 'comment-region)

(global-set-key [f1] 'eval-region)


(global-set-key [f3] 'eshell) 
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

(setq process-coding-system-alist (cons '("bash" . raw-text-unix)
					process-coding-system-alist))

;; The above code uses the default faces for
;;decoration. If you would like to customize the
;;attributes of the faces, you can use the
;;following startup code to get started:

;; (cond ((fboundp 'global-font-lock-mode)
;;        ;; Customize face attributes
;;        (setq font-lock-face-attributes
;;              ;; Symbol-for-Face Foreground Background Bold Italic Underline
;;              '((font-lock-comment-face "DarkGreen")
;;                (font-lock-string-face "Sienna")
;;                (font-lock-keyword-face "RoyalBlue")
;;                (font-lock-function-name-face "Blue")
;;                (font-lock-variable-name-face "Brown")
;;                (font-lock-type-face "Brown")
;; ;;               (font-lock-reference-face "Purple")
;;                ))
;;        ;; Load the font-lock package.
;;        (require 'font-lock)
;;        ;; Maximum colors
;;        (setq font-lock-maximum-decoration t)
;;        ;; Turn on font-lock in all modes that support it
;;        (global-font-lock-mode t)))

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


;;{{{ Script creation and debugging


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

;; fast path to dired, right where you are
(defun dired-here()   (interactive) (dired "." nil) )
(global-set-key "\C-cD" 'dired-here)

;; Define an easy way to move up in a dired directory, 
;; To instantly view a file in the web browser (IE or whatever) (this needs a current directory argument to work better):
;; **NOTE: These bindings must be in a mode-hook, since dired isn't automatically
;; loaded on startup and so it's keymap is void until you go into dired. 
(add-hook `dired-mode-hook
  `(lambda ()
     (define-key dired-mode-map "\C-u" 'dired-up-directory)
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
     ((looking-at ".app") (setq directory "~"))
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



(setq column-number-mode t)

; Indent c code four spaces
(setq c-basic-offset 4)
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

;; magit 

;; (require 'git)
; git hooks, using old magit until can get 24.4 on ubuntu
(load-file "~/dot.emacs/.init.d/magit/magit.el")  
(require 'magit)

(eval-when-compile (require 'cl))

;; (set-face-background 'hl-line "#220") 

;;(set-face-background 'highlight-current-line-face "light yellow")
;; (set-face-background 'hl-line "#111") 

;; To convert a file that contains tabs and spaces to one that contains only spaces, use the untabify command: M-x untabify

;; NOTES
;; Browsing the URL of the current buffer
;; The command `browse-url-of-buffer' gets a browser to render the URL associated with the file in the current buffer. This is great when editing web-related pages. For example, when you are editing an HTML file, you can have it rendered in your favourite browser by typing `C-c C-v'. This is especially nice if you are using a browser within Emacs like w3 or w3m; then you can have your source in the top window of an Emacs frame, and the output in the bottom frame, and simply regenerate whenever you like without ever having to leave the source!

;; will load that to the end
;; ;; (server-mode)

;; allow for use of emacsclient, if using window emais
;; (if window-system
;;     (server-start)
;; )

;; Type M-x desktop-clear to empty the Emacs desktop. This kills all buffers except for internal ones, and clears the global variables listed in desktop-globals-to-c
(desktop-save-mode 1)

 (ignore-errors
  (load-file "~/dot.emacs/.init.d/bash_shell.el")
  (load-file "~/dot.emacs/.init.d/org_mode_settings.el")
  (load-file "~/dot.emacs/.init.d/ruby_settings.el")
  (load-file "~/dot.emacs/.init.d/eshell_setup.el")
  (load-file "~/dot.emacs/.init.d/new_stuff_settings.el")
;;  (load-file "~/dot.emacs/.init.d/cloudformation-mode.el")
  (load-file "~/dot.emacs/.init.d/thingatpt+.el")
  (load-file "~/dot.emacs/.init.d/omnifocus.el")
 )

;; mac only load ups
(when (equal system-type 'darwin)
 (ignore-errors
  (load-file "~/dot.emacs/.init.d/mac_only.el")
))

;; omnifocus
(autoload 'send-region-to-omnifocus "omnifocus-capture" "Send region to OmniFocus" t)
(global-set-key (kbd "C-c C-o") 'send-region-to-omnifocus)
;
;; tramp

;;http://www.emacswiki.org/emacs/TrampMode
;;http://stackoverflow.com/questions/28484460/using-emacs-on-aws-ubuntu-system-meta-and-esc-keys-dont-work
(require 'tramp)
(setq tramp-default-method "ssh")
;;  C-x C-f /remotehost:filename  RET (or /method:user@remotehost:filename)
;;  (find-file "/ssh:dmiley@ec2-54-69-139-242.us-west-2.compute.amazonaws.com:")


;; theme performance can vary on diff env's. (doesn't seem to work inside tmux for instance)
(load-theme 'twilight t)  ;; textmate twilight, ignore lisp code warning with the t at the end
;;  (color-theme-sanityinc-tomorrow-night)


;; company mode.  this is working but heavy rails dependency to date (and pry in Gemfile) read setu

;; (global-company-mode t)

;; (add-hook 'ruby-mode-hook 'robe-mode)

;; (push 'company-robe company-backends)
;; (eval-after-load 'company
;;     '(push 'company-robe company-backends))

;;(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
;;    (rvm-activate-corresponding-ruby))

(rvm-activate-corresponding-ruby)

;; (add-hook 'robe-mode-hook 'ac-robe-setup)

;; should disable flychecks of the documentation
(with-eval-after-load 'flycheck
    (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(setq default-major-mode 'text-mode)

;; show current function in modeline
(which-func-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;			F U N C T I O N S
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;ASCII table function
(defun ascii-table ()
  "Print the ascii table. Based on a defun by Alex Schroeder <asc@bsiag.com>"
  (interactive)  (switch-to-buffer "*ASCII*")  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))  (let ((i 0))
								 (while (< i 254)      (setq i (+ i 1))
									(insert (format "%4d %c\n" i i))))  (beginning-of-buffer))


(require 'xclip)

(require 'docker)
(require 'docker-tramp)
(require 'dockerfile-mode)

;; https://github.com/dgutov/robe  some good docs

;;A Dockerfile mode for emacs

;; (add-to-list 'load-path "/your/path/to/dockerfile-mode/")

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
;;Adds syntax highlighting as well as the ability to build the image directly (C-c C-b) from the buffer.

;;You can specify the image name in the file itself by adding a line like this at the top of your Dockerfile.

;; ## -*- docker-image-name: "your-image-name-here" -*-
;; If you don't, you'll be prompted for an image name each time you build.

;; https://github.com/Silex/docker.el

;; Display time in the mode line
;; Put this line last to prove (by the time in the mode line) 
;; that the .emacs loaded without error to this point.
(setq display-time-day-and-date t )
;(setq display-time-24hr-format t)
(display-time)


;;-----------------------------------------------------------------------------
;; END File      : DOT Emacs file.
;;-----------------------------------------------------------------------------

