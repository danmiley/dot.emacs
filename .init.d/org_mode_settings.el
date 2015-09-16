;; (setq load-path (cons "~/home/dot.emacs.d/org-7.3/lisp" load-path))
;; (setq load-path (cons "~/home/dot.emacs.d/org-7.3/contrib/lisp" load-path))
;; (require 'org-install)

;; (setq org-directory "~/home/dot.emacs.d/org-7.3")

;; ;; (setq load-path (cons "~/Dropbox/home/dot.emacs.d/org-mode/lisp" load-path))
;; ;; (setq load-path (cons "~/Dropbox/home/dot.emacs.d/org-mode/contrib/lisp" load-path))
;; (require 'org-install)

;; ;; (setq org-directory "~/Dropbox/home/dot.emacs.d/org-mode")

;; ;; (require 'ox-confluence)

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

;; Here are the keys in the minor mode.

;; TAB       -- execute normal TAB command, if point doesn't move, try to
;;              toggle the visibility of the block.
;; <S-tab>   -- execute normal <S-tab command, if point doesn't move, try to
;;              toggle the visibility of all the blocks.
;; ;; (add-to-list 'load-path "~/Dropbox/home/dot.emacs.d/plugins/hideshow-org")
;; ;; (require 'hideshow-org)
;; ;; (global-set-key "\C-ch" 'hs-org/minor-mode)
