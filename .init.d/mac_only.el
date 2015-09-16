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


(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))
(if (eq system-type 'darwin)
    (progn
      (setq interprogram-cut-function 'paste-to-osx)
              (setq interprogram-paste-function 'copy-from-osx)))
