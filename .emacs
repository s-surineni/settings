;; emacs related functionality
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
(windmove-default-keybindings)		;move windows with shift and arrow keys
(setq confirm-nonexistent-file-or-buffer nil)
(setq make-backup-files nil);stop making bakcup files
(setq column-number-mode t)
(setq-default cursor-type 'bar)
(desktop-save-mode 1)
(electric-indent-mode 1)
(electric-pair-mode t)

(setq scroll-step 1)
(setq show-paren-delay 0)
(show-paren-mode t)

;; encoding system
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)
(delete-selection-mode 1)


;; key bindings
(global-set-key (kbd "RET") 'newline-and-indent);return will indent now
(global-set-key [f5] 'revert-buffer)
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "C-b") 'backward-word)

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

(global-set-key (kbd "C-d") 'my-delete-word) ; cut
(global-set-key (kbd "C-e") 'move-end-of-line)
(global-set-key (kbd "C-f") 'forward-word)
(global-set-key (kbd "C-k") 'query-replace)
(global-set-key (kbd "C-l") 'goto-line) ; Ctrl+Shift+k
(global-set-key (kbd "C-o") 'find-file) ; finding files
(global-set-key (kbd "C-q") 'rgrep) ; finding files
(global-set-key (kbd "C-t") 'magit-status) ; finding files
(global-set-key (kbd "C-v") 'yank)

(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
When called repeatedly, append copy subsequent lines.
When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').

URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2015-09-18"
  (interactive)
  (let (ŠÎp1 ŠÎp2)
    (if current-prefix-arg
        (progn (setq ŠÎp1 (point-min))
               (setq ŠÎp2 (point-max)))
      (progn
        (if (use-region-p)
            (progn (setq ŠÎp1 (region-beginning))
                   (setq ŠÎp2 (region-end)))
          (progn (setq ŠÎp1 (line-beginning-position))
                 (setq ŠÎp2 (+ (line-end-position) 1))))))
    (if (eq last-command this-command)
        (progn
          (kill-append "\n" nil)
          (forward-line 1)
          (end-of-line)
          (kill-append (buffer-substring-no-properties (line-beginning-position) (line-end-position)) nil)
          (message "Line copy appended"))
      (progn
        (kill-ring-save ŠÎp1 ŠÎp2)
        (if current-prefix-arg
            (message "Buffer text copied")
          (message "Text copied"))))))

(global-set-key (kbd "C-w") 'xah-copy-line-or-region)
(global-set-key (kbd "C-y") 'scroll-up)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-/") 'comment-or-uncomment-region-or-line);for commenting and uncommenting
(global-set-key (kbd "<backtab>") 'company-complete)
(global-set-key (kbd "M-a") 'beginning-of-buffer)
(global-set-key (kbd "M-b") 'backward-char)
(global-set-key (kbd "M-d") 'delete-and-join-forward)
(global-set-key (kbd "M-e") 'end-of-buffer)
(global-set-key (kbd "M-f") 'forward-char)
(global-set-key (kbd "M-q") 'find-dired)
(global-set-key (kbd "M-s") 'save-buffer)

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

(global-set-key (kbd "M-w") 'xah-cut-line-or-region)
;; (global-set-key (kbd "M-y") 'scroll-down)
(global-set-key (kbd "<M-backspace>") 'my-backward-delete-word)
(global-set-key (kbd "C-S-a") 'mark-whole-buffer)
(global-set-key (kbd "C-S-b") 'windmove-left)

(defun my-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (my-delete-word (- arg)))

(global-set-key (kbd "C-S-d") 'my-backward-delete-word)
(global-set-key (kbd "C-S-e") 'delete-window)
(global-set-key (kbd "C-S-f") 'windmove-right)
(global-set-key (kbd "C-S-h") 'split-window-below);splits window horizontally
(global-set-key (kbd "C-S-n") 'windmove-down)
(global-set-key (kbd "C-S-p") 'windmove-up)
(global-set-key (kbd "C-S-v") 'split-window-right);splits windwo vertically
(global-set-key (kbd "C-S-x") 'server-edit) ;
;; (global-set-key (kbd "C-x b") 'windmove-left) ;
;; (global-set-key (kbd "C-x f") 'windmove-right)
(global-set-key (kbd "C-x g") 'magit-status)

(defun volatile-kill-buffer ()
   "Kill current buffer unconditionally."
   (interactive)
   (let ((buffer-modified-p nil))
     (kill-buffer (current-buffer))))
(add-hook 'python-mode-hook
          (lambda()
            (local-unset-key (kbd "<backtab>"))))

(global-set-key (kbd "C-x k") 'volatile-kill-buffer)
;; (global-set-key (kbd "C-x n") 'windmove-down)
;; (global-set-key (kbd "C-x p") 'windmove-up)
(global-set-key (kbd "M-S-d") 'my-delete-line-backward) ; Ctrl+Shift+k
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'package)
(require 'cl)
(package-initialize)
;; prelude start


(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("elpa" . "http://elpa.gnu.org/packages/") t)
(defvar prelude-packages
  '(aggressive-indent org web-mode projectile epc
		      js2-mode ac-js2 tern transpose-frame elpy
		      flx-ido magit beacon dash dash-functional
		      flymake-jslint keyfreq groovy-mode)
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
;; prelude end

;; enabling theme
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (load-theme 'solarized t)

;; enabling modes
(beacon-mode 1)

;;customizing modes

;; ido-mode
(setq ido-create-new-buffer 'always)

;;flx-ido mode
(ido-mode 1)
(flx-ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; js mode
(add-hook 'js-mode-hook 'flymake-jslint-load)

;; keyfreq-mode
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;; web-mode
(setq web-mode-markup-indent-offset 4)

;; python config
(elpy-enable)
(setq python-check-command (expand-file-name "~/.local/bin/flake8"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b2910a5302ac57f0a18a5d2a3fda6206996350e981666a501ffb4406666c7d60" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
