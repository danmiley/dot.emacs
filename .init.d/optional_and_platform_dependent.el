 (ignore-errors
  (load-file "~/dot.emacs/.init.d/omnifocus.el")
  (load-file "~/dot.emacs/.init.d/new_stuff_settings.el")
 )

;; mac only load ups
(when (equal system-type 'darwin)
 (ignore-errors
  (load-file "~/dot.emacs/.init.d/mac_only.el")
))

;; do github gists here  https://github.com/defunkt/gist.el

(load-file "~/dot.emacs/.init.d/vendor/gist.el")
(require 'gist)


;; omnifocus
(autoload 'send-region-to-omnifocus "omnifocus-capture" "Send region to OmniFocus" t)
(global-set-key (kbd "C-c C-o") 'send-region-to-omnifocus)
;

;; mac only load ups
(when (equal system-type 'darwin)
 (ignore-errors
  (load-file "~/dot.emacs/.init.d/mac_only.el")
))

;; Dash is a mac doc inspector

;;https://github.com/stanaka/dash-at-point
(autoload 'dash-at-point "dash-at-point"
  "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)



;; mac only browser ingteraction

;; google-region
(defun google-region (&optional flags)
  "Google the selected region"
  (interactive)
  (let ((query (buffer-substring (region-beginning) (region-end))))
    (browse-url (concat "http://www.google.com/search?ie=utf-8&oe=utf-8&q=" query))))
;; press control-c g to google the selected region
(global-set-key (kbd "C-c g") 'google-region)
;; google-region

;; load-url-region
;; http://www.adobe.com
(defun load-url-region (&optional flags)
  "open a web browser with the selected region"
  (interactive)
  (let ((query (buffer-substring (region-beginning) (region-end))))
    (browse-url (concat "" query))))
;; press control-c g to google the selected region
(global-set-key (kbd "C-c l") 'load-url-region)

(defun yank-chrome-url ()
  "Yank current URL from Chrome"
  (interactive)
  (require 'apples-mode)
    (apples-do-applescript "tell application \"Google Chrome\"
 get URL of active tab of first window
end tell"
			   #'(lambda (url status script)
			       ;; comes back with quotes which we strip off
			       (insert (subseq url 1 (1- (length url)))))))
(global-set-key (kbd "C-c y") 'yank-chrome-url)



(require 'docker)
(require 'docker-tramp)
(require 'dockerfile-mode)

;;A Dockerfile mode for emacs

;; (add-to-list 'load-path "/your/path/to/dockerfile-mode/")

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
;;Adds syntax highlighting as well as the ability to build the image directly (C-c C-b) from the buffer.

;;You can specify the image name in the file itself by adding a line like this at the top of your Dockerfile.

;; ## -*- docker-image-name: "your-image-name-here" -*-
;; If you don't, you'll be prompted for an image name each time you build.

;; https://github.com/Silex/docker.el

(load-file "~/dot.emacs/fixme.el")   ;; colors the tags used to indicate what should be fixed(load-file "~/dot.emacs.d/python-mode.el")`xxu`x
(load-file "~/dot.emacs/superbracket.el") 
