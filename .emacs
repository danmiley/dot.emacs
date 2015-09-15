
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


(put 'set-goal-column 'disabled nil)

;;try to get the cloud version of the emacs settings.  if not, try ~/dot.emacs.d./.emacs
;;(load-file "~//Dropbox/home/dot.emacs.d/.emacs")
(put 'upcase-region 'disabled nil)


;; (load-library "autostart") 

;;How to use html-helper-mode?
;;Add the below lines to your .emacs.el.

(add-to-list 'auto-mode-alist '("\\.html\\'" . html-helper-mode))

(set-frame-parameter nil 'alpha 0.9) 

(load-file "~/dot.emacs/.init.d/.emacs")
