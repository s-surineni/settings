(setq frame-title-format "%b");;filename as window name
(setq inhibit-splash-screen t);;stops tutorial at the beginning
(setq scroll-step 1);;line by line scrolling
(global-linum-mode t);;may be numbers on left??
(column-number-mode 1);;column number
(setq initial-scratch-message nil);;empty buffer will be null now
(tool-bar-mode -1);;no tool bar
(menu-bar-mode -1);;no menu bar
(scroll-bar-mode -1);;hides scroll bar
(setq x-select-enable-clipboard t);respond to system clipboard
(global-set-key (kbd "RET") 'newline-and-indent);return will indent now
(global-set-key (kbd "C-;") 'comment-or-uncomment-region);for commenting and uncommenting
(show-paren-mode 1);shows the parenthesis pair
;;deletes hilighted text
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)
;;deletes hilighted text

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
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ;starts org mode
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

;auto-pair
(add-hook 'prog-mode-hook #'(lambda() (autopair-mode)))
;auto-pair

;for themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")


;(load-theme 'solarized t)
;;for theme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized)))
 '(custom-safe-themes (quote ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(desktop-save-mode t)
 '(frame-background-mode (quote dark))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(kill-whole-line t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(enable-theme 'solarized)


;;cut whole line
(defun xah-cut-line-or-region ()
  "Cut current line, or text selection.
When `universal-argument' is called first, cut whole buffer (respects `narrow-to-region').

URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2015-06-10"
  (interactive)
  (if current-prefix-arg
      (progn ; not using kill-region because we don't want to include previous kill
        (kill-new (buffer-string))
        (delete-region (point-min) (point-max)))
    (progn (if (use-region-p)
               (kill-region (region-beginning) (region-end) t)
             (kill-region (line-beginning-position) (line-beginning-position 2))))))


;key bindings


;;deleting and not killing
(defun my-delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (delete-region
   (point)
   (progn
     (forward-word arg)
     (point))))

(defun my-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (my-delete-word (- arg)))

(defun my-delete-line ()
  "Delete text from current position to end of line char.
This command does not push text to `kill-ring'."
  (interactive)
  (delete-region
   (point)
   (progn (end-of-line 1) (point)))
  (delete-char 1))

(defun my-delete-line-backward ()
  "Delete text between the beginning of the line to the cursor position.
This command does not push text to `kill-ring'."
  (interactive)
  (let (p1 p2)
    (setq p1 (point))
    (beginning-of-line 1)
    (setq p2 (point))
    (delete-region p1 p2)))

;;for copying current line if region is not active
(defun my-kill-ring-save (beg end flash)
      (interactive (if (use-region-p)
                       (list (region-beginning) (region-end) nil)
                     (list (line-beginning-position)
                           (line-beginning-position 2) 'flash)))
      (kill-ring-save beg end)
      (when flash
        (save-excursion
          (if (equal (current-column) 0)
              (goto-char end)
            (goto-char beg))
          (sit-for blink-matching-delay))))
    (global-set-key [remap kill-ring-save] 'my-kill-ring-save)

; bind them to emacs's default shortcut keys:
(global-set-key (kbd "C-S-d") 'my-delete-line-backward) ; Ctrl+Shift+k
(global-set-key (kbd "C-d") 'my-delete-line)
(global-set-key (kbd "M-d") 'my-delete-word)
(global-set-key (kbd "<M-backspace>") 'my-backward-delete-word)
(global-set-key (kbd "C-w") 'xah-cut-line-or-region) ; cut
(global-set-key (kbd "C-o") 'find-file) ; finding files
(global-set-key (kbd "C-s") 'save-buffer) ; cut
(global-set-key (kbd "C-f") 'isearch-forward) ; cut
;(global-set-key (kbd "C-f") 'isearch-repeat-forward) ; cut
(global-set-key (kbd "C-S-f") 'isearch-backward) ; cut
;(global-set-key (kbd "C-S-f") 'isearch-repeat-backward) ; cut
(global-set-key (kbd "C-S-k") 'kill-buffer) ; cut
(global-set-key (kbd "C-S-b") 'switch-to-buffer) ; cut
(global-set-key (kbd "C-c") 'kill-ring-save) ; cut
