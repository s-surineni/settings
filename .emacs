;; emacs related functionality
(server-start)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(windmove-default-keybindings)		;move windows with shift and arrow keys
(setq confirm-nonexistent-file-or-buffer nil)
(setq make-backup-files nil);stop making bakcup files
(setq column-number-mode t)
(setq-default cursor-type 'bar)
(desktop-save-mode 1)
(electric-indent-mode 1)
(setq uniquify-buffer-name-style 'forward)
(setq echo-keystrokes 0.1)
(setq scroll-step 1)
(setq-default frame-title-format "%l %b (%f)")
;; reverts buffers changed on disk
(global-auto-revert-mode)
;; mode line format
;; (setq mode-line-format
;;           (list
;;            ;; value of `mode-name'
;;            "%m: "
;;            ;; value of current buffer name
;;            "buffer %b, "
;;            ;; value of current line number
;;            "line %l "))
;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "/home/sampath/.emacs.d/lisp/")
(add-to-list 'load-path "/home/sampath/.emacs.d/themes/tomorrow-theme/")

;; load the packaged named xyz.
;; (load "seq-24") ;; best not to include the ending “.el” or “.elc”

;; encoding system
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)
(delete-selection-mode 1)

(defun emacs-process-p (pid)
  "If pid is the process ID of an emacs process, return t, else nil.
Also returns nil if pid is nil."
  (when pid
    (let ((attributes (process-attributes pid)) (cmd))
      (dolist (attr attributes)
        (if (string= "comm" (car attr))
            (setq cmd (cdr attr))))
      (if (and cmd (or (string= "emacs" cmd) (string= "emacs.exe" cmd))) t))))

(defadvice desktop-owner (after pry-from-cold-dead-hands activate)
  "Don't allow dead emacsen to own the desktop file."
  (when (not (emacs-process-p ad-return-value))
    (setq ad-return-value nil)))
;;; desktop-override-stale-locks.el ends here

;; key bindings
(global-set-key (kbd "RET") 'newline-and-indent);return will indent now
(global-set-key [f5] 'revert-buffer)
(global-set-key (kbd "C--") 'split-window-below)
(global-set-key (kbd "C-\\") 'split-window-right)
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
;; (global-set-key (kbd "<return>") 'newline-and-indent)
(global-set-key (kbd "C-d") 'my-delete-word) ; cut
(global-set-key (kbd "C-e") 'move-end-of-line)
(global-set-key (kbd "C-f") 'forward-word)
(global-set-key (kbd "C-h") 'projectile-find-file)
(global-set-key (kbd "C-S-h") 'projectile-find-file-other-window)
(global-set-key (kbd "C-j") 'ido-switch-buffer)
(global-set-key (kbd "C-S-j") 'ido-switch-buffer-other-window)
(global-set-key (kbd "C-k") 'query-replace)
(global-set-key (kbd "C-l") 'goto-line) ; Ctrl+Shift+k
(global-set-key (kbd "C-o") 'find-file) ; finding files
(global-set-key (kbd "C-q") 'rgrep) ; finding files
(global-set-key (kbd "C-t") 'magit-status) ; finding files
(setq magit-refresh-status-buffer nil)
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

(global-set-key (kbd "C-/") 'comment-or-uncomment-region-or-line);for commenting and uncommenting
(global-set-key (kbd "M-/") 'comment-dwim);for commenting and uncommenting
(global-set-key (kbd "<backtab>") 'auto-complete)
(global-set-key (kbd "M-a") 'beginning-of-buffer)
(global-set-key (kbd "M-b") 'backward-char)
(global-set-key (kbd "M-]") 'sp-backward-unwrap-sexp)
(global-set-key (kbd "M-d") 'delete-char)
(global-set-key (kbd "M-[") 'sp-unwrap-sexp)
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
(global-set-key (kbd "C-S-y") 'scroll-down)
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
(global-set-key (kbd "C-S-n") 'windmove-down)
(global-set-key (kbd "C-S-p") 'windmove-up)
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


;; after search is done we will endup at beginning of the search
(add-hook 'isearch-mode-end-hook
          #'endless/goto-match-beginning)
(defun endless/goto-match-beginning ()
  "Go to the start of current isearch match.
Use in `isearch-mode-end-hook'."
  (when (and isearch-forward
             (number-or-marker-p isearch-other-end)
             (not mark-active)
             (not isearch-mode-end-hook-quit))
    (goto-char isearch-other-end)))


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
  '(aggressive-indent auto-complete auto-package-update
		      color-theme-sanityinc-tomorrow hungry-delete
  		      diminish fill-column-indicator org web-mode
		      projectile epc ido-vertical-mode
		      company js2-mode js2-refactor ac-js2 tern transpose-frame elpy
		      flx-ido magit beacon dash dash-functional
		      keyfreq groovy-mode smartparens)
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
(add-to-list 'custom-theme-load-path "/home/sampath/.emacs.d/themes/tomorrow-theme/")
;; (require 'tomorrow-night-theme)
;; (load-theme tomorrow-night-paradise t)

;; for automatically updating the packages
(add-to-list 'load-path "/path/to/auto-package-update")
(require 'auto-package-update)
(auto-package-update-maybe)
(auto-package-update-at-time "03:00")
(setq auto-package-update-delete-old-versions t)

;; enabling modes

(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")
(beacon-mode 1)
;; (add-hook 'after-init-hook 'global-company-mode)
(projectile-global-mode)
;; (rich-minority-mode 1)
(smartparens-global-mode t)
;; (setq sml/no-confirm-load-theme t)
;; (setq sml/theme 'dark)
;; (sml/setup)
(ido-vertical-mode 1)
(require 'auto-complete)
(global-auto-complete-mode t)
(setq ac-ignore-case nil)
(require 'hungry-delete)
(global-hungry-delete-mode)
(which-function-mode 1)
(yas-global-mode 1)
(define-key yas-minor-mode-map (kbd "C-<tab>") 'yas-expand)

(define-globalized-minor-mode my-global-fci-mode fci-mode turn-on-fci-mode)
(my-global-fci-mode 1)
(setq fci-handle-truncate-lines nil)
;; to solve mis-alignment of auto-complete mode
(defvar sanityinc/fci-mode-suppressed nil)
(defadvice popup-create (before suppress-fci-mode activate)
  "Suspend fci-mode while popups are visible"
  (set (make-local-variable 'sanityinc/fci-mode-suppressed) fci-mode)
  (when fci-mode
    (turn-off-fci-mode)))
(defadvice popup-delete (after restore-fci-mode activate)
  "Restore fci-mode when all popups have closed"
  (when (and (not popup-instances) sanityinc/fci-mode-suppressed)
    (setq sanityinc/fci-mode-suppressed nil)
    (turn-on-fci-mode)))
;; this completes auto-complete issue

;; this is to solve problem with company-mode
(defvar-local company-fci-mode-on-p nil)

(defun company-turn-off-fci (&rest ignore)
  (when (boundp 'fci-mode)
    (setq company-fci-mode-on-p fci-mode)
    (when fci-mode (fci-mode -1))))

(defun company-maybe-turn-on-fci (&rest ignore)
  (when company-fci-mode-on-p (fci-mode 1)))

(add-hook 'company-completion-started-hook 'company-turn-off-fci)
(add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
(add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci)
;; company-mode issue solved

;;customizing modes

;; auto-complete mode
(ac-config-default)
(setq ac-delay 0)

;; company mode
;; (setq company-idle-delay 0)

;; diminish mode
(diminish 'projectile-mode)
(diminish 'auto-complete-mode)
(diminish 'smartparens-mode)

;; (eval-after-load "filladapt" '(diminish 'filladapt-mode))

 
;; ido-mode
(setq ido-create-new-buffer 'always)

;;flx-ido mode
(ido-mode 1)
(flx-ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; js mode
;; (add-hook 'js-mode-hook 'flymake-jslint-load)

;; keyfreq-mode
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)
;; mmm-mode
;; (require 'mmm-mode)
;; (mmm-add-mode-ext-class 'web-mode "\\.vue\\'" 'vue)
;; (setq mmm-global-mode 'maybe)


;; smartparens
(require 'smartparens-config)
(show-smartparens-global-mode +1)

;; vertical ido mode
(setq ido-vertical-define-keys 'C-n-and-C-p-only)


;; web-mode
(setq web-mode-markup-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))
(add-hook 'after-change-major-mode-hook
	  (lambda () (if (string= major-mode "web-mode")
			 (turn-off-fci-mode) (turn-on-fci-mode))))

;; python config
(elpy-enable)
;; (setq python-check-command (expand-file-name "~/.local/bin/flake8"))

;; added by theme

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(fci-rule-color "#383838")
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(put 'upcase-region 'disabled nil)
;; (load-theme 'zenburn t)
(color-theme-sanityinc-tomorrow-eighties)
