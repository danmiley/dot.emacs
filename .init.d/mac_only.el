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
