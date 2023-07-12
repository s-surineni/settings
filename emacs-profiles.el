;; set user-emacs-directory to where you clone prelude
;; user-emacs-directory=/home/sampath/projects/eemacs
;; (setq my-profile
;;       '("My Profile"
;;         (user-emacs-directory . "/home/sampath/projects/eemacs")))
(("default" . ((user-emacs-directory . "~/.emacs.default")))
 ;; ("spacemacs" . ((user-emacs-directory . "/home/sampath/projects/eemacs/spacemacs")
 ;;                 (env . (("SPACEMACSDIR" . "~/.spacemacs.d")))))
 ("spacemacs" . ((user-emacs-directory . "/home/sampath/projects/eemacs/spacemacs")))
 ("prelude" . ((user-emacs-directory . "/home/sampath/projects/eemacs/prelude")))
 ("doom" . ((user-emacs-directory . "~/config/doomemacs")
            (env . (("DOOMDIR" . "~/doom-config")))))
 )
