;; set user-emacs-directory to where you clone prelude
;; user-emacs-directory=/home/sampath/projects/eemacs
;; (setq my-profile
;;       '("My Profile"
;;         (user-emacs-directory . "/home/sampath/projects/eemacs")))
(("default" . ((user-emacs-directory . "~/.emacs.default")))
 ;; ("spacemacs" . ((user-emacs-directory . "/home/sampath/projects/eemacs/spacemacs")
 ;;                 (env . (("SPACEMACSDIR" . "~/.spacemacs.d")))))
 ("spacemacs" . ((user-emacs-directory . "~/ironman/eemacs/spacemacs")))
 ("prelude" . ((user-emacs-directory . "/home/sampath/projects/eemacs/prelude")))
 ("doom" . ((user-emacs-directory . "~/ironman/eemacs/doomemacs")
            (env . (("DOOMDIR" . "~/ironman/settings/doom/")))))
 )


;;   `$DOOMDIR'
;;     The location of your private configuration for Doom Emacs (defaults to
;;     ~/.config/doom or ~/.doom.d; whichever it finds first). This is *not* the
;;     place you've cloned doomemacs/doomemacs to. The `--doomdir' option also sets
;;     this variable.