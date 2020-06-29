;;
;; Steve Ackermann's win32 perl customised Emacs 
;; This file MUST be C:\.emacs
;;
;; (For use with win32 Emacs 20.5.1 or greater only)
;; http://www.gnu.org/software/emacs/windows/ntemacs.html 
;;
;; ---------------------------------------------------------------------------
;; Hot keys (print this information for reference):
;; ---------------------------------------------------------------------------
;;          F1 - Goto line
;;    Shift-F1 - View emacs FAQ
;;          F2 - Comment highlighted region (highlight a region first!)
;; Shift-F2 F2 - Uncomment highlighted region (highlight a commented region first!)
;;          F3 - Switch to a command prompt shell
;;          F4 - Correctly indent a highlighted region (highlight a region first!)
;;          F5 - Goto next window (buffer)
;;    Shift-F5 - Show all available colours
;;          F6 - Other window (when in split window mode)
;;    Shift-F6 - Replace text
;;          F7 - Insert the perl code: print "\n";
;;    Shift-F7 - Insert the perl code: or die " : $!";
;;          F8 - Run the current perl code
;;          F8 - Debug the current perl code (Requires the ActiveState perl debugger)
;;          F9 - Spilt window
;;         F10 - Unspilt window
;;         F11 - Replace text
;;         F12 - Undo

;; PC Function Keys
(global-set-key [f1] 'goto-line) 
(global-set-key [(shift f1)] 'view-emacs-FAQ)
(global-set-key [f2] 'comment-region) 
(global-set-key [(shift f2)] 'universal-argument) ;uncomment is Shift-F2 F2 
(global-set-key [f3] 'shell) 
(global-set-key [f4] 'indent-region)
(global-set-key [(shift f4)] 'wrap-all-lines) 
(global-set-key [f5] 'bury-buffer)
(global-set-key [(shift f5)] 'list-colors-display)
;; WARNING: f6 is set by pc-selection-mode
;;(global-set-key [(shift f6)] ') 
(global-set-key [f7] 'insert-perl-print)
(global-set-key [(shift f7)] 'insert-perl-die)
(global-set-key [f8] 'run-perl) 
(global-set-key [(shift f8)] 'debug-perl) 
(global-set-key [f9] 'split-window-vertically)
(global-set-key [f10] 'delete-other-windows) ; unsplit window
(global-set-key [f11] 'query-replace)
(global-set-key [f12] 'undo)
(global-set-key [(shift f12)] 'open-dot-emacs)

;; Startup the Speedbar
;(speedbar-frame-mode)

;; Don't want "//" to bugger things up in a filename.
(setq filename-handler-alist nil)

;; Make searches case insensitive
(setq case-fold-search t)

;; Make control+pageup/down scroll the other buffer
(global-set-key [(control next)] 'scroll-other-window)
(global-set-key [(control prior)] 'scroll-other-window-down)

;; Set titles for frame and icon (%f == file name, %b == buffer name)
(setq-default frame-title-format (list "Emacs: %f"))
(setq-default icon-title-format "Emacs - %b")

;; Place Emacs in the location (0, 80) on screen 
(setq initial-frame-alist
  '(
     (top               . 0)
     (left              . 80)
  )
)

;; ---------------------------------------------------------------------------
; Highlighting
;; ---------------------------------------------------------------------------
;; highlight region between point and mark
;(transient-mark-mode t)
;; highlight during query
(setq query-replace-highlight t)        
;; highlight incremental search
(setq search-highlight t)               

;; Show matching parenthesis. How can you live without it.
(show-paren-mode t)

;; Don't add new lines to the end of a file when using down-arrow key
(setq next-line-add-newlines nil)

;; Start off in "C:/" dir.
(cd "C:/")

;; Dont show the GNU splash screen
(setq inhibit-startup-message t)

;; Make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;; Open unidentified files in text mode
(setq default-major-mode 'text-mode)

;; ---------------------------------------------------------------------------
;;Key Bindings
;; ---------------------------------------------------------------------------
;; Windows-like selection and key bindings, but don't replace marked text when writing
(pc-bindings-mode)
(pc-selection-mode)
(delete-selection-mode nil)

(setq my-author-name (getenv "USER"))
(setq user-full-name (getenv "USER"))
(setq default-directory "C:/")

;; ---------------------------------------------------------------------------
;; Current line & column of cursor in the mode line (bar at the bottom)
;; ---------------------------------------------------------------------------
(line-number-mode 1)
(setq column-number-mode t)
;; show current function in modeline
;(which-func-mode t)                 


;; ---------------------------------------------------------------------------
;; Do only one line scrolling.
;; ---------------------------------------------------------------------------
(setq scroll-step 1)

;; ---------------------------------------------------------------------------
;; Don't wrap long lines.
;; ---------------------------------------------------------------------------
(set-default 'truncate-lines t)

;; ---------------------------------------------------------------------------
;; Nevertheless I'd like to have the possibility to see what is out of my
;; view.
;; ---------------------------------------------------------------------------
(require 'auto-show)
(auto-show-mode 1)
(setq-default auto-show-mode t)

;; ---------------------------------------------------------------------------
;; Make the region visible (but only up to the next operation on it)
;; ---------------------------------------------------------------------------
(setq transient-mark-mode t)

;; Do an autoinsert of the top of programming language files (currently C/C++)
(add-hook 'find-file-hooks 'auto-insert)
(setq c-companion-file "Headder.c")

;; ---------------------------------------------------------------------------
;; Colours ("Colors" in some other languages)
;; --------------------------------------------------------------------------
;; Give me colours in major editing modes!!!!!
(require 'font-lock)
(global-font-lock-mode t)
 
;; The mode line (bar at the bottom)
(add-hook 'font-lock-mode-hook
	  '(lambda ()
             (set-face-background 'modeline               "Blue4")
             (set-face-foreground 'modeline               "Gold")
; 	     (set-face-foreground 'secondary-selection "red")
;              (set-face-background 'highlight               "yellow")
))

;; Background
;(set-background-color "white smoke")

;;Comments in italics
(setq w32-enable-italics t)
;(make-face-italic 'font-lock-comment-face)

;; Override default text colours
(custom-set-faces
;  '(font-lock-comment-face ((((class color)) (:foreground "firebrick"))))
 '(font-lock-comment-face ((((class color)) (:foreground "green4"))))
 '(region ((((class color)) (:background "wheat"))))
;  '(highlight ((((class color)) (:background "green1"))))
;  '(font-lock-string-face ((((class color)) (:foreground "green4"))))
;  '(font-lock-keyword-face ((((class color)) (:foreground "orange"))))
 '(font-lock-type-face ((((class color)) (:foreground "blue"))))
;  '(font-lock-variable-name-face ((((class color)) (:foreground "brown"))))
;   '(font-lock-function-name-face ((((class color)) (:foreground "royal blue"))))
  '(font-lock-function-name-face ((((class color)) (:foreground "firebrick"))))
)

; don't make pesky backup files
(setq make-backup-files nil)
; don't use version numbers for backup files
(setq version-control 'never)
;not sure what these do
(setq text-mode-hook 'turn-on-auto-fill)
(put 'eval-expression 'disabled nil)

(custom-set-variables
 '(find-file-run-dired t)
)

;; In abbrev mode, inserting an abbreviation causes it to expand
;; and be replaced by its expansion.
; (setq-default abbrev-mode t)
; (read-abbrev-file "~/.abbrev_defs")
; (setq save-abbrevs t)

;; ---------------------------------------------------------------------------
;; Bind major editing modes to certain file extensions 
;;----------------------------------------------------------------------------
(setq auto-mode-alist
      '(("\\.[Cc][Oo][Mm]\\'" . text-mode)
        ("\\.bat\\'" . bat-generic-mode)
        ("\\.inf\\'" . inf-generic-mode)
        ("\\.rc\\'" . rc-generic-mode)
        ("\\.reg\\'" . reg-generic-mode)
        ("\\.cob\\'" . cobol-mode)
        ("\\.cbl\\'" . cobol-mode)
        ("\\.te?xt\\'" . text-mode)
        ("\\.c\\'" . c-mode)
        ("\\.h\\'" . c++-mode)
        ("\\.tex$" . LaTeX-mode)
        ("\\.sty$" . LaTeX-mode)
        ("\\.bbl$" . LaTeX-mode)
        ("\\.bib$" . BibTeX-mode)
        ("\\.el\\'" . emacs-lisp-mode)
        ("\\.scm\\'" . scheme-mode)
        ("\\.l\\'" . lisp-mode)
        ("\\.lisp\\'" . lisp-mode)
        ("\\.f\\'" . fortran-mode)
        ("\\.F\\'" . fortran-mode)
        ("\\.for\\'" . fortran-mode)
        ("\\.p\\'" . pascal-mode)
        ("\\.pas\\'" . pascal-mode)
        ("\\.ad[abs]\\'" . ada-mode)
        ("\\.\\([pP][Llm]\\|al\\)\\'" . perl-mode)
	("\\.cgi$"  . perl-mode)
        ("\\.s?html?\\'" . sgml-mode)
        ("\\.idl\\'" . c++-mode)
        ("\\.cc\\'" . c++-mode)
        ("\\.hh\\'" . c++-mode)
        ("\\.hpp\\'" . c++-mode)
        ("\\.C\\'" . c++-mode)
        ("\\.H\\'" . c++-mode)
        ("\\.cpp\\'" . c++-mode)
        ("\\.[cC][xX][xX]\\'" . c++-mode)
        ("\\.hxx\\'" . c++-mode)
        ("\\.c\\+\\+\\'" . c++-mode)
        ("\\.h\\+\\+\\'" . c++-mode)
        ("\\.m\\'" . objc-mode)
        ("\\.java\\'" . java-mode)
        ("\\.ma?k\\'" . makefile-mode)
        ("\\(M\\|m\\|GNUm\\)akefile\\(\\.in\\)?" . makefile-mode)
        ("\\.am\\'" . makefile-mode)
        ("\\.mms\\'" . makefile-mode)
        ("\\.texinfo\\'" . texinfo-mode)
        ("\\.te?xi\\'" . texinfo-mode)
        ("\\.s\\'" . asm-mode)
        ("\\.S\\'" . asm-mode)
        ("\\.asm\\'" . asm-mode)
        ("ChangeLog\\'" . change-log-mode)
        ("change\\.log\\'" . change-log-mode)
        ("changelo\\'" . change-log-mode)
        ("ChangeLog\\.[0-9]+\\'" . change-log-mode)
        ("changelog\\'" . change-log-mode)
        ("changelog\\.[0-9]+\\'" . change-log-mode)
        ("\\$CHANGE_LOG\\$\\.TXT" . change-log-mode)
        ("\\.scm\\.[0-9]*\\'" . scheme-mode)
        ("\\.[ck]?sh\\'\\|\\.shar\\'\\|/\\.z?profile\\'" . sh-mode)
        ("\\(/\\|\\`\\)\\.\\(bash_profile\\|z?login\\|bash_login\\|z?logout\\)\\'" . sh-mode)
        ("\\(/\\|\\`\\)\\.\\(bash_logout\\|[kz]shrc\\|bashrc\\|t?cshrc\\|esrc\\)\\'" . sh-mode)
        ("\\(/\\|\\`\\)\\.\\([kz]shenv\\|xinitrc\\|startxrc\\|xsession\\)\\'" . sh-mode)
        ("\\.mm\\'" . nroff-mode)
        ("\\.me\\'" . nroff-mode)
        ("\\.ms\\'" . nroff-mode)
        ("\\.man\\'" . nroff-mode)
        ("\\.[12345678]\\'" . nroff-mode)
        ("\\.TeX\\'" . TeX-mode)
        ("\\.sty\\'" . LaTeX-mode)
        ("\\.cls\\'" . LaTeX-mode)
        ("\\.clo\\'" . LaTeX-mode)
        ("\\.bbl\\'" . LaTeX-mode)
        ("\\.bib\\'" . BibTeX-mode)
        ("\\.m4\\'" . m4-mode)
        ("\\.mc\\'" . m4-mode)
        ("\\.mf\\'" . metafont-mode)
        ("\\.mp\\'" . metapost-mode)
        ("\\.vhdl?\\'" . vhdl-mode)
        ("\\.article\\'" . text-mode)
        ("\\.letter\\'" . text-mode)
        ("\\.tcl\\'" . tcl-mode)
        ("\\.exp\\'" . tcl-mode)
        ("\\.itcl\\'" . tcl-mode)
        ("\\.itk\\'" . tcl-mode)
        ("\\.icn\\'" . icon-mode)
        ("\\.sim\\'" . simula-mode)
        ("\\.mss\\'" . scribe-mode)
        ("\\.f90\\'" . f90-mode)
        ("\\.lsp\\'" . lisp-mode)
        ("\\.awk\\'" . awk-mode)
        ("\\.prolog\\'" . prolog-mode)
        ("\\.tar\\'" . tar-mode)
        ("\\.\\(arc\\|zip\\|lzh\\|zoo\\|jar\\)\\'" . archive-mode)
        ("\\.\\(ARC\\|ZIP\\|LZH\\|ZOO\\|JAR\\)\\'" . archive-mode)
        ("\\`/tmp/Re" . text-mode)
        ("/Message[0-9]*\\'" . text-mode)
        ("/drafts/[0-9]+\\'" . mh-letter-mode)
        ("\\.zone\\'" . zone-mode)
        ("\\`/tmp/fol/" . text-mode)
        ("\\.y\\'" . c-mode)
        ("\\.lex\\'" . c-mode)
        ("\\.oak\\'" . scheme-mode)
        ("\\.sgml?\\'" . sgml-mode)
        ("\\.xml\\'" . sgml-mode)
        ("\\.dtd\\'" . sgml-mode)
        ("\\.ds\\(ss\\)?l\\'" . dsssl-mode)
        ("\\.idl\\'" . c++-mode)
        ("[]>:/\\]\\..*emacs\\'" . emacs-lisp-mode)
        ("\\`\\..*emacs\\'" . emacs-lisp-mode)
        ("[:/]_emacs\\'" . emacs-lisp-mode)
        ("\\.ml\\'" . lisp-mode)))

;; ---------------------------------------------------------------------------
;;			MENU CUSTOMISATION 
;; ---------------------------------------------------------------------------
;;Add a 'Perl' menu
(define-key global-map [menu-bar perl-menu]
  (cons "Perl" (make-sparse-keymap "Perl")))
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [goto-line-label] '("Goto Line" . goto-line) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [comment-region-label] '("Comment Highlighted Region" . comment-region) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [shell-label] '("MS-DOS Command Prompt" . shell) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [indent-region-label] '("Indent Highlighted Region   (f4)" . indent-region) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [wrap-all-lines-label] '("Wrap Lines" . wrap-all-lines) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [bury-buffer-label] '("Previous Window" . bury-buffer) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [insert-perl-print-label] '("Insert: print \"\\n\";" . insert-perl-print) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [insert-perl-die-label] '("Insert: or die \" : $!\";" . insert-perl-die) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [perl-menu-separator1] '("--" . perl-menu-separator1) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [run-perl-label] '("Run Current Perl Code" . run-perl) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [debug-perl-label] '("Debug Current Perl Code" . debug-perl) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [perl-menu-separator2] '("--" . perl-menu-separator2) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [split-window-vertically-label] '("Split window                      (f9)" . split-window-vertically) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [delete-other-windows-label] '("Unsplit window                  (f10)" . delete-other-windows) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [query-replace-label] '("Replace                            (f11)" . query-replace) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [undo-label] '("Undo                                (f12)" . undo) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [perl-menu-separator3] '("--" . perl-menu-separator3) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [end-of-defun-label] '("End of function" . end-of-defun) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [beginning-of-defun-label] '("Beginning of function" . beginning-of-defun) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [ascii-table-label] '("Show ASCII Table" . ascii-table) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [cperl-mode-label] '("Switch to cperl-mode" . cperl-mode) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [perl-menu-separator4] '("--" . perl-menu-separator4) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [unix-to-dos-label] '("Reformat UNIX -> DOS" . unix-dos) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [dos-to-unix-label] '("Reformat DOS -> UNIX" . dos-unix) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [perl-menu-separator5] '("--" . perl-menu-separator5) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [comments-in-italics-label] '("Comments in Italics" . make-comment-italic) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [comments-in-unitalics-label] '("Comments NOT in Italics" . make-comment-unitalic) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [comments-invisible-label] '("Invisible Comments" . make-comment-invisible) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [comments-visible-label] '("Visible Comments" . make-comment-visible) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [comments-red-label] '("Red Comments" . make-comment-red) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [perl-menu-separator6] '("--" . perl-menu-separator6) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [desktop-save-label] '("Save Desktop" . desktop-save) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [desktop-clear-label] '("Clear Desktop" . desktop-clear) t)
(define-key-after (lookup-key global-map [menu-bar perl-menu])
  [desktop-remove-label] '("Disable Desktop Function" . desktop-remove) t)

; (define-key global-map [menu-bar Misc] nil)	;disable the menu

;; Add Speedbar to "Tools" menu
(cond (window-system
       (define-key-after (lookup-key global-map [menu-bar tools])
         [speedbar-menu-separator] '("--" . speedbar-menu-separator) t)
       (define-key-after (lookup-key global-map [menu-bar tools])
         [speedbar] '("Speedbar" . speedbar-frame-mode) t)
       (define-key-after (lookup-key global-map [menu-bar tools])
         [speedbar2] '("(Selects files with middle mouse button)" . speedbar-frame-mode) t)
       (define-key-after (lookup-key global-map [menu-bar tools])
         [speedbar-menu-separator2] '("--" . speedbar-menu-separator2) t)
       (define-key-after (lookup-key global-map [menu-bar tools])
         [tetris-menu-label] '("Tetris" . tetris) t)
       (define-key-after (lookup-key global-map [menu-bar tools])
         [gomoku-menu-label] '("Gomoku" . gomoku) t)
       (define-key-after (lookup-key global-map [menu-bar tools])
         [doctor-menu-label] '("Emacs Doctor" . doctor) t)
))

;;Add a variable and function index to the menu
(require 'imenu)
(add-hook 'c-mode-hook (function (lambda () (imenu-add-to-menubar 'Func))))
(add-hook 'c++-mode-hook (function (lambda () (imenu-add-menubar-index))))
(add-hook 'perl-mode-hook (function (lambda () (imenu-add-menubar-index))))
(add-hook 'perl-mode-hook (function (lambda () (imenu-add-to-menubar 'Func))))
(add-hook 'java-mode-hook (function (lambda () (imenu-add-menubar-index))))

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

;;Convert DOS cr-lf to UNIX newline
(defun dos-unix () (interactive) (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;;Convert UNIX newline to DOS cr-lf
(defun unix-dos () (interactive) (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;;make-comment-italic
(defun make-comment-italic ()
  (interactive "*")
  (make-face-italic 'font-lock-comment-face))

;;make-comment-unitalic
(defun make-comment-unitalic ()
  (interactive "*")
  (make-face-unitalic 'font-lock-comment-face))

;;make-comment-invisible
(defun make-comment-invisible ()
  (interactive "*")
  (custom-set-faces
 '(font-lock-comment-face ((((class color)) (:foreground "white"))))))

;;make-comment-visible
(defun make-comment-visible ()
  (interactive "*")
  (custom-set-faces
 '(font-lock-comment-face ((((class color)) (:foreground "green4"))))))

;;make-comment-red
(defun make-comment-red ()
  (interactive "*")
  (custom-set-faces
 '(font-lock-comment-face ((((class color)) (:foreground "red3"))))))

;;run the current perl program
(defun run-perl ()
  (interactive "*")
  (setq perl-buffer-name buffer-file-name)
  (shell)
  (setq perl-run-command "perl ")
  (insert perl-run-command)
  (insert perl-buffer-name)
)

;;debug the current perl program
(defun debug-perl ()
  (interactive "*")
  (setq perl-buffer-name buffer-file-name)
  (shell)
  (setq perl-run-command "perl -d ")
  (insert perl-run-command)
  (insert perl-buffer-name)
)

;;Add perl print template
(defun insert-perl-print ()
  "Add perl print template"
  (interactive "*")
  (setq steve-var "print \"\\n\";")
  (insert steve-var)
)

;;Add perl die template
(defun insert-perl-die ()
  "Add perl die template"
  (interactive "*")
  (setq steve-var "or die \" : $!\";")
  (insert steve-var)
)

(defun wrap-all-lines ()
  "Enable line wrapping"
  (interactive) ;this makes the function a command too
  (set-default 'truncate-lines nil)
)

(defun open-dot-emacs ()
  "opening-dot-emacs"
  (interactive) ;this makes the function a command too
  (find-file "C:\.emacs")
)

;;(desktop-load-default)
;;(desktop-read)

;; Display time in the mode line
;; Put this line last to prove (by the time in the mode line) 
;; that the .emacs loaded without error to this point.
(setq display-time-day-and-date t )
;(setq display-time-24hr-format t)
(display-time)

