; sane path
;;(setq path "/bin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/google_appengine")
(setq path "/usr/local/bin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin/git:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:/Users/dan/bin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin/git:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:/Users/dan/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin:/usr/local/mysql/bin:/local/mysql/bin:/usr/local/mysql/bin")

(setenv "PATH" path)

; more bash-like autocomplete
(setq eshell-cmpl-cycle-completions nil)

; automatically save history
(setq eshell-save-history-on-exit t)

; ignore version control directories when autocompleting
(setq eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\)/\\'")

; can't write over prompt, that would be weird
(setq comint-prompt-read-only nil)

; scroll to bottom on output, more like a terminal
(setq eshell-scroll-to-bottom-on-output t)
(setq eshell-scroll-show-maximum-output t)

; colorful shell
(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

; escape the shell
(add-hook 'eshell-mode-hook
  '(lambda nil (local-set-key "\C-u" 'eshell-kill-input)))
