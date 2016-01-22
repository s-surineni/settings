 ;encoding system
(set-language-environment "UTF-8")					
(set-default-coding-systems 'utf-8-unix)
;functions
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

(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
When called repeatedly, append copy subsequent lines.
When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').

URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2015-09-18"
  (interactive)
  (let (¦Îp1 ¦Îp2)
    (if current-prefix-arg
        (progn (setq ¦Îp1 (point-min))
               (setq ¦Îp2 (point-max)))
      (progn
        (if (use-region-p)
            (progn (setq ¦Îp1 (region-beginning))
                   (setq ¦Îp2 (region-end)))
          (progn (setq ¦Îp1 (line-beginning-position))
                 (setq ¦Îp2 (+ (line-end-position) 1))))))
    (if (eq last-command this-command)
        (progn
          (kill-append "\n" nil)
          (forward-line 1)
          (end-of-line)
          (kill-append (buffer-substring-no-properties (line-beginning-position) (line-end-position)) nil)
          (message "Line copy appended"))
      (progn
        (kill-ring-save ¦Îp1 ¦Îp2)
        (if current-prefix-arg
            (message "Buffer text copied")
          (message "Text copied"))))))

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

(defun delete-and-join-forward (&optional arg)
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (progn (forward-char 1)
             (just-one-space 0)
             (backward-char 1)
             (my-delete-line))
    (my-delete-line)))

(defun my-delete-line-backward ()
  "Delete text between the beginning of the line to the cursor position.
This command does not push text to `kill-ring'."
  (interactive)
  (let (p1 p2)
    (setq p1 (point))
    (beginning-of-line 1)
    (setq p2 (point))
    (delete-region p1 p2)))

(defun volatile-kill-buffer ()
   "Kill current buffer unconditionally."
   (interactive)
   (let ((buffer-modified-p nil))
     (kill-buffer (current-buffer))))
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "<backtab>"))))
;key bindings
(global-set-key (kbd "RET") 'newline-and-indent);return will indent now
(global-set-key (kbd "<f2>") 'xah-cut-line-or-region) ; cut
(global-set-key (kbd "<f3>") 'xah-copy-line-or-region) ; copy
(global-set-key [f5] 'revert-buffer)
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "C-b") 'backward-word)
(global-set-key (kbd "C-d") 'my-delete-word) ; cut
(global-set-key (kbd "C-e") 'move-end-of-line)
(global-set-key (kbd "C-f") 'forward-word)
(global-set-key (kbd "C-k") 'volatile-kill-buffer)
(global-set-key (kbd "C-l") 'goto-line) ; Ctrl+Shift+k
(global-set-key (kbd "C-o") 'find-file) ; finding files
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "C-w") 'xah-copy-line-or-region)
(global-set-key (kbd "C-y") 'scroll-up)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region-or-line);for commenting and uncommenting
(global-set-key (kbd "<backtab>") 'company-complete)
(global-set-key (kbd "M-a") 'beginning-of-buffer)
(global-set-key (kbd "M-b") 'backward-char)
(global-set-key (kbd "M-d") 'delete-and-join-forward)
(global-set-key (kbd "M-e") 'end-of-buffer)
(global-set-key (kbd "M-f") 'forward-char)
(global-set-key (kbd "M-w") 'xah-cut-line-or-region)
(global-set-key (kbd "M-y") 'scroll-down)
(global-set-key (kbd "<M-backspace>") 'my-backward-delete-word)
(global-set-key (kbd "C-S-a") 'mark-whole-buffer)
(global-set-key (kbd "C-S-b") 'windmove-left)
(global-set-key (kbd "C-S-d") 'my-backward-delete-word)
(global-set-key (kbd "C-S-e") 'delete-window)
(global-set-key (kbd "C-S-f") 'windmove-right)
(global-set-key (kbd "C-S-h") 'split-window-below);splits window horizontally
(global-set-key (kbd "C-S-n") 'windmove-down)
(global-set-key (kbd "C-S-p") 'windmove-up)
(global-set-key (kbd "C-S-s") 'save-buffer) ; cut
(global-set-key (kbd "C-S-v") 'split-window-right);splits windwo vertically
(global-set-key (kbd "C-S-x") 'server-edit) ;
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "M-S-d") 'my-delete-line-backward) ; Ctrl+Shift+k
(global-set-key (kbd "C-x C-b") 'ibuffer)
(require 'package)
(package-initialize)
(require 'cl)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("elpa" . "http://elpa.gnu.org/packages/") t)
(defvar prelude-packages
  '(aggressive-indent org solarized-theme web-mode projectile epc 
		      js2-mode ac-js2 tern transpose-frame elpy
		      flx-ido magit beacon dash dash-functional)
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  (cl-loop for p in prelude-packages
	   when (not (package-installed-p p)) do (cl-return nil)
	   finally (cl-return t)))

(unless (prelude-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs Prelude is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p prelude-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'prelude-packages)
(beacon-mode 1)
(windmove-default-keybindings)		;move windows with shift and arrow keys
(fset 'yes-or-no-p 'y-or-n-p)
;setting env variables
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)
(setq make-backup-files nil);stop making bakcup files
(elpy-enable)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-disable-faces nil)
 '(company-dabbrev-downcase nil)
 '(cursor-type (quote bar))
 '(custom-enabled-themes (quote (solarized-light)))
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(delete-selection-mode t)
 '(desktop-save-mode t)
 '(electric-indent-mode t)
 '(electric-pair-mode t)
 '(flx-ido-mode t)
 '(global-aggressive-indent-mode nil)
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(ido-mode (quote both) nil (ido))
 '(ido-use-faces nil)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(initial-scratch-message nil)
 '(menu-bar-mode nil)
 '(revert-without-query (quote ("*")))
 '(scroll-bar-mode nil)
 '(scroll-step 1)
 '(server-mode t)
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(solarized-scale-org-headlines nil)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify))
 '(web-mode-markup-indent-offset 4)
 '(which-function-mode t)
 '(yas-global-mode t nil (yasnippet)))
(projectile-global-mode)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;functions
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
;; (ac-config-default)
;; (ac-set-trigger-key "TAB")
;; (ac-set-trigger-key "<tab>")
(dolist (command '(yank yank-pop))
   (eval `(defadvice ,command (after indent-region activate)
            (and (not current-prefix-arg)
                 (member major-mode '(emacs-lisp-mode lisp-mode
                                                      clojure-mode    scheme-mode
                                                      haskell-mode    ruby-mode
                                                      rspec-mode      python-mode
                                                      c-mode          c++-mode
                                                      objc-mode       latex-mode
                                                      plain-tex-mode  js-mode
						      js2-mode        javascript-mode))
                 (let ((mark-even-if-inactive transient-mark-mode))
                   (indent-region (region-beginning) (region-end) nil))))))

(defun buffer-mode (buffer-or-string)
  "Returns the major mode associated with a buffer."
  (with-current-buffer buffer-or-string
    major-mode))

;; for commenting uncommenting current line
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
	(setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))
(when (not (boundp 'remote-file-name-inhibit-cache))
  (setq remote-file-name-inhibit-cache t))
;enables auto complete in all places!!!!
;; (defun auto-complete-mode-maybe ()
;;   "No maybe for you. Only AC!"
;;   (auto-complete-mode 1))


(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-script-padding 4)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-hook 'after-init-hook 'global-company-mode)
;; (require 'auto-complete-config)
;; (setq ac-show-menu-immediately-on-auto-complete t) ;
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)


(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

;; (add-hook 'js-mode-hook (lambda () (tern-mode t)))
;; (eval-after-load 'tern
;;   '(progn
;;      (require 'tern-auto-complete)
;;      (tern-ac-setup)))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; SHOW FILE PATH IN FRAME TITLE
(setq-default frame-title-format "%l %b (%f)")
(setq web-mode-engines-alist '(("django" . "\\.html\\'")))
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-auto-expanding t)
(setq web-mode-enable-css-colorization t)
              
