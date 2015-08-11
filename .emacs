(setq inhibit-splash-screen t);;stops tutorial at the beginning
(setq scroll-step 1);;line by line scrolling
(column-number-mode 1);;column number
(setq initial-scratch-message nil);;empty buffer will be null now
(scroll-bar-mode -1);;no scrollbar
(tool-bar-mode -1);;no tool bar
(menu-bar-mode -1);;no menu bar
(setq x-select-enable-clipboard t);respond to system clipboard
(global-set-key (kbd "RET") 'newline-and-indent);return will indent now
(global-set-key (kbd "C-;") 'comment-or-uncomment-region);for commenting and uncommenting

;(require 'autopair);turns auto-parining on

;;loads extra packages
(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq package-archive-enable-alist '(("melpa" deft magit)))
;;loads extra packages

;;list of needed packages
(defvar abedra/packages '(auto-complete
                          web-mode
                          )
  "Default packages")
;;list of needed packages

;(defun abedra/packages-installed-p ()
 ; (loop for pkg in abedra/packages
  ;      when (not (package-installed-p pkg)) do (return nil)
   ;     finally (return t)))

;(unless (abedra/packages-installed-p)
 ; (message "%s" "Refreshing package database...")
  ;(package-refresh-contents)
  ;(dolist (pkg abedra/packages)
   ; (when (not (package-installed-p pkg))
    ;  (package-install pkg))))

;package manager config
(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ;; TODO: Maybe, use this after emacs24 is released
                  ;; (development versions of packages)
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)

;package manager config

;specifying package list
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar tmtxt/packages
  '(auto-complete web-mode))
(dolist (p tmtxt/packages)
  (when (not (package-installed-p p))
    (package-install p)))
;specifying package list

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;auto complete

;;tern mode
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))
;;tern mode

;webmode
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;webmode
