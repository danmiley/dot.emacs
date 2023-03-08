# dot.emacs
std emacs configuration across os's

```mermaid
  graph TD;
      A-->B;
      A-->C;
      B-->D;
      C-->D;
```


NEW:
ruby
c-c i - doc lookup
c-c d - 'dash' app doc lookup

;;IDO mode is awesome. It's essential to know the basic shortcuts, especially the escape hatch Ctrl-f (introduction-to-ido-mode/) which gets you out of ido-mode.
IDO mode dired : 'c-c d'


TODO/BLOCKED:
Magit 0.7 is hard installed until emacs 24.4 is avail on ubuntu

Helpful:

Textmate:
 This minor mode exists to mimick TextMate's awesome
 ;; features.

;;    ⌘T - Go to File
;;  ⇧⌘T - Go to Symbol
;;    ⌘L - Go to Line
;;  ⇧⌘L - Select Line (or expand Selection to select lines)
;;    ⌘/ - Comment Line (or Selection/Region)
;;    ⌘] - Shift Right (currently indents region)
;;    ⌘[ - Shift Left  (not yet implemented)
;;  ⌥⌘] - Align Assignments
;;  ⌥⌘[ - Indent Line
;;    ⌥↑ - Column Up
;;    ⌥↓ - Column Down
;;  ⌘RET - Insert Newline at Line's End
;;  ⌥⌘T - Reset File Cache (for Go to File)

;; A "project" in textmate-mode is determined by the presence of
;; a .git directory, an .hg directory, a Rakefile, or a Makefile.

;; You can configure what makes a project root by appending a file
;; or directory name onto the `*textmate-project-roots*' list.

;; If no project root indicator is found in your current directory,
;; textmate-mode will traverse upwards until one (or none) is found.
;; The directory housing the project root indicator (e.g. a .git or .hg
;; directory) is presumed to be the project's root.

;; In other words, calling Go to File from
;; ~/Projects/fieldrunners/app/views/towers/show.html.erb will use
;; ~/Projects/fieldrunners/ as the root if ~/Projects/fieldrunners/.git
;; exists.
