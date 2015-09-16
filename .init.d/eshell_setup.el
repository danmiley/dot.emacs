(if (file-exists-p "~/.shell/variables")
    ;; TODO: load $PATH from that file.
    ;; TODO: Add $PATH to exec-path
    nil)

  ;;; Necessary to make some modes aware of binaries, such as sql-mysql
(push "/usr/local/bin" exec-path)

(setenv "PATH" (concat (getenv "PATH") ":" "/usr/local/bin"))

;; if OSX...
(if (equal window-system 'ns)
    (push "/Applications/Emacs.app/Contents/MacOS/bin" exec-path))

(defun if-string-match-then-result (to-match pairs)
      "Takes a string to match and a list of pairs, the first element
  of the pairs is a regexp to test against the string, the second of
  which is a return value if it matches."
      (catch 'break
	(dolist (val pairs)
	  (if (string-match-p (car val) to-match)
	      (progn
		(throw 'break (cadr val)))))
	(throw 'break nil)))

(setq eshell-history-size nil) ;; sets it to $HISTSIZE

(defun eshell/extract (file)
  (eshell-command-result (concat (if-string-match-then-result
				  file
				  '((".*\.tar.bz2" "tar xjf")
				    (".*\.tar.gz" "tar xzf")
				    (".*\.bz2" "bunzip2")
				    (".*\.rar" "unrar x")
				    (".*\.gz" "gunzip")
				    (".*\.tar" "tar xf")
				    (".*\.tbz2" "tar xjf")
				    (".*\.tgz" "tar xzf")
				    (".*\.zip" "unzip")
				    (".*\.jar" "unzip")
				    (".*\.Z" "uncompress")
				    (".*" "echo 'Could not extract the requested file:'")))
				 " " file)))

(defun mass-create-eshells (names)
      "Creates several eshells at once with the provided names. Names
  are surrounded in astrisks."
      (dolist (name names)
	(let ((eshell-buffer-name (concat "*" name "*")))
	  (eshell))))

(defun eshell/clear ()
  "clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

(defun eshell/mcd (dir)
  "make a directory and cd into it"
  (interactive)
  (eshell/mkdir "-p" dir)
  (eshell/cd dir))

(defun eshell/git-delete-unreachable-remotes ()
  "Delete remote git branches which have been merged into master"
  (interactive)
  (if (not (string-equal "master" (magit-get-current-branch)))
      (message "Not on master. This probably doesn't do what you want."))
      (shell-command "git branch -r --merged | grep -v '/master$' | sed -E 's/origin\\/(.*)/:\\1/' | xargs git push origin"))
