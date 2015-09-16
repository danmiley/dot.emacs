;; scpaste

;; SCPaste is sort of like gists, but it uploads the paste to your own server. It was particularly helpful when dealing with things at Google when I couldn't post it publically (or even privately to an external service). One of the neat things it does is it uses your color scheme (if you use a colored emacs) in the paste.

;; scpaste
(setq scpaste-http-destination "http://caesium.justinlilly.com/pastes"
              scpaste-scp-destination "justinlilly@caesium.justinlilly.com:/var/www/blog/pastes")
