;; mac only packages
;;   dash-functional
;;   kdate-at-point
;; apples-mode

;; http://puntoblogspot.blogspot.com/2014/01/ann-helm-dash-documentation-browser-for.html

(defun mac-string-to-utxt (string &optional coding-system)
      (or coding-system (setq coding-system mac-system-coding-system))
      (let (data encoding)
        (when (and (fboundp 'mac-code-convert-string)
                   (memq (coding-system-base coding-system)
                         (find-coding-systems-string string)))
          (setq coding-system
                (coding-system-change-eol-conversion coding-system 'unix))
          (let ((str string))
            (when (and (eq system-type 'darwin)
                       (eq coding-system 'japanese-shift-jis-mac))
              (setq encoding mac-text-encoding-mac-japanese-basic-variant)
              (setq str (subst-char-in-string ?\\ ?\x80 str))
              (subst-char-in-string ?\\ ?\x5c str t)
              ;; ASCII-only?
              (if (string-match "\\`[\x00-\x7f]*\\'" str)
                  (setq str nil)))
            (and str
                 (setq data (mac-code-convert-string
                             (encode-coding-string str coding-system)
                             (or encoding coding-system) nil)))))
        (or data (encode-coding-string string (if (eq (byteorder) ?B)
                                                  'utf-16be
                                                'utf-16le)))))

(defun open-finder-here ()
  "current buffers directory opened in macos finder"
	  (interactive)
	 (shell-command (concat "open . "  )))
(global-set-key "\C-x\C-o" 'open-finder-here)


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


;; emacs transparency

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

;; redirect prompt string to google lucky
(defun gll-word-at-point (&optional flags)
  "Google the selected region"
  (interactive)
  (let* ((default (region-or-word-at-point))
	 (query (read-string (format "Feeling Lucky? (%s): "  default) default)))
  (browse-url (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=&btnI=I'm+Feeling+Lucky&aq=f&aqi=&aql=&oq=&gs_rfai=&q=" query))))

(global-set-key (kbd "C-c w") 'gll-word-at-point)

;; redirect prompt string to google lucky
(defun gll-region (&optional flags)
  "Google the selected region"
  (interactive)
  (setq query (read-string "feeling lucky?: "))
  (browse-url (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=&btnI=I'm+Feeling+Lucky&aq=f&aqi=&aql=&oq=&gs_rfai=&q=" query)))


;; press control-c g to google the selected region
(global-set-key (kbd "C-c f") 'gll-region)

(if window-system
(cond ((fboundp 'global-font-lock-mode)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t))))

;; opacity / transparency

;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))

;; You can use the following snippet after you’ve set the alpha as above to assign a toggle to “C-c t”:

(set-frame-parameter nil 'alpha 0.9)

;; loading for mac only

;;  Add in my paths
;; (when (equal system-type 'darwin)
	;; (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
	;; (push "/opt/local/bin" exec-path))

;;Using Emacs from within the terminal in OSX completely breaks copy+paste support. This chunk of code from emacswiki restores it.

;; xclip for coy/paste

;;Well, here is a little hack that lets you launch arbitrary files from a Dired view of a directory; using the operating system's registered application; ie, if you navigate to a .pdf file and hit 'l', Acrobat (or whatever) will launch and show you the file. Now I never have to use the accursed Finder. Works on Mac OS X and Ubuntu; might need modifcations for other systems.
;;; Hack dired to launch files with 'l' key.  Put this in your ~/.emacs file

;; (defun dired-launch-command ()
;;   (interactive)
;;   (dired-do-shell-command
;;    (case system-type
;;      (gnu/linux "gnome-open") ;right for gnome (ubuntu), not for other systems
;;      (darwin "open"))
;;    nil
;;    (dired-get-marked-files t current-prefix-arg)))


;; ;; view the file
;; (setq dired-load-hook
;;       (function
;;        (lambda ()
;; 	 ;; Load extras:
;; 	;; (load "dired-x")
;; 	 ;; How to define your own key bindings:
;; 	 (define-key dired-mode-map " " 'scroll-up)
;; 	 (define-key dired-mode-map "l" 'dired-launch-command))))


;;Ensure dired-launch is enabled in dired-mode:

(define-key dired-launch-mode-map (kbd "l") 'dired-launch-command)

(dired-launch-enable)

;; Open files in dired mode using 'open'  -k on key -z in dired
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map (kbd "z")
       (lambda () (interactive)
         (let ((fn (dired-get-file-for-visit)))
           (start-process "default-app" nil "open" fn))))))

;; ;; Set default font
;; (set-face-attribute 'default nil
;;                     :family "Source Code Pro"
;;                     :height 110
;;                     :weight 'normal
;;                     :width 'normal)
;; (add-to-list 'default-frame-alist
;;              '(font . "Source Code Pro"))
