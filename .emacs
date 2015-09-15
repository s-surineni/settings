
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized");for themes

;; Disable loading of “default.el” at startup,
;; in Fedora all it does is fix window title which I rather configure differently
(setq inhibit-default-init t)

;; SHOW FILE PATH IN FRAME TITLE
(setq-default frame-title-format "%l %b (%f)")
(set-language-environment "UTF-8")					;encoding system

(set-default-coding-systems 'utf-8-unix)

(tool-bar-mode -1);;no tool bar
(menu-bar-mode -1);;no menu bar
(scroll-bar-mode -1);;hides scroll bar

(setq inhibit-splash-screen t);;stops tutorial at the beginning
(setq initial-scratch-message nil);;empty buffer will be null now
(setq scroll-step 1);;line by line scrolling

(show-paren-mode 1);shows the parenthesis pair
(setq show-paren-delay 0);no delay for showing matching parenthesis
(setq x-select-enable-clipboard t);respond to system clipboard
(which-function-mode 1);shows which function the line is in
(delete-selection-mode t);;deletes hilighted text
(transient-mark-mode t);deletes hilighted text

(add-hook 'prog-mode-hook #'(lambda() (autopair-mode)));auto-pair

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
When `universal-argument' is called first, copy whole buffer (respects `narrow-to-region').

URL `http://ergoemacs.org/emacs/emacs_copy_cut_current_line.html'
Version 2015-05-06"
  (interactive)
  (let (ξp1 ξp2)
    (if current-prefix-arg
        (progn (setq ξp1 (point-min))
               (setq ξp2 (point-max)))
      (progn (if (use-region-p)
                 (progn (setq ξp1 (region-beginning))
                        (setq ξp2 (region-end)))
               (progn (setq ξp1 (line-beginning-position))
                      (setq ξp2 (line-end-position))))))
    (kill-ring-save ξp1 ξp2)
    (if current-prefix-arg
        (message "buffer text copied")
      (message "text copied"))))

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

;for copying current line if region is not active
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

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))


;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ;; TODO: Maybe, use this after emacs24 is released
                  ;; (development versions of packages)
                  ("melpa" . "http://melpa.org/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)

(require 'transpose-frame)

;;; Required packages
;;; everytime emacs starts, it will automatically check if those packages are
;;; missing, it will install them automatically
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar tmtxt/packages
  '(auto-complete
    autopair
    org
    magit
    solarized-theme
    web-mode
    ))
(dolist (p tmtxt/packages)
  (when (not (package-installed-p p))
    (package-install p)))

(package-initialize)

;; auto complete mod
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;auto complete

(add-to-list 'ac-modes 'org-mode);auto complete in org mode

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;;tern mode
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))
;;tern mode

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode));webmodeb

;;auto indent yanked test
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode    scheme-mode
						     haskell-mode    ruby-mode
						     rspec-mode      python-mode
						     c-mode          c++-mode
						     objc-mode       latex-mode
						     plain-tex-mode  web-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)


;;for theme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(cursor-type (quote bar))
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "ccaa9318209539f3390b663e5313c9036fd3da9c9327e4a1b99b10aad91f5dc1" "fd9ca77431b92fdf4c0ef0026de0059bcbadb738fc22fe1bc8d8f2ce1a1e7607" "06770ee8b0d0185a3fb824045536fa71964e1984afa51af6b76c008486deca53" "aa0ed50536db21db2316f8e1fef83b298e2b6c19c7e0a6a1689bf1483246fb62" "19352d62ea0395879be564fc36bc0b4780d9768a964d26dfae8aad218062858d" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(desktop-save-mode t)
 '(fci-rule-color "#383838")
 '(frame-background-mode (quote dark))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(kill-whole-line t)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(vc-annotate-background "#2B2B2B")
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
 '(vc-annotate-very-old-color "#DC8CC3"))

;(enable-theme 'solarized);theme enabling

(defvar prelude-packages
  '(ack-and-a-half auctex clojure-mode coffee-mode deft expand-region
                   gist groovy-mode haml-mode haskell-mode inf-ruby
                   markdown-mode paredit projectile python
                   sass-mode rainbow-mode scss-mode solarized-theme
                   volatile-highlights yaml-mode yari zenburn-theme)
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
;;; prelude-packages.el ends here

(autopair-global-mode) ;; enable autopair in all buffers

(defun auto-complete-mode-maybe ()
  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))
(setq ac-disable-faces nil)

(global-set-key (kbd "M-S-d") 'my-delete-line-backward) ; Ctrl+Shift+k
(global-set-key (kbd "M-d") 'my-delete-line)
(global-set-key (kbd "C-d") 'my-delete-word)
(global-set-key (kbd "C-S-d") 'my-backward-delete-word)
(global-set-key (kbd "<M-backspace>") 'my-backward-delete-word)

(global-set-key (kbd "<f2>") 'xah-cut-line-or-region) ; cut
(global-set-key (kbd "<f3>") 'xah-copy-line-or-region) ; copy
(global-set-key (kbd "C-o") 'find-file) ; finding files
(global-set-key (kbd "C-S-s") 'save-buffer) ; cut
(global-set-key (kbd "M-b") 'switch-to-buffer) ; cut
(global-set-key (kbd "C-b") 'backward-word) ; cut
(global-set-key (kbd "C-f") 'forward-word) ; cut
(global-set-key [f5] 'revert-buffer)
(global-set-key (kbd "C-k") 'kill-buffer)
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "C-S-e") 'delete-window)
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "M-a") 'beginning-of-buffer)
(global-set-key (kbd "M-e") 'end-of-buffer)
(global-set-key (kbd "C-e") 'move-end-of-line)
(global-set-key (kbd "RET") 'newline-and-indent);return will indent now
(global-set-key (kbd "C-;") 'comment-or-uncomment-region);for commenting and uncommenting
(global-set-key (kbd "<escape>") 'keyboard-quit);for commenting and uncommenting
(global-set-key (kbd "C-S-h") 'split-window-below);splits window horizontally
(global-set-key (kbd "C-S-v") 'split-window-right);splits windwo vertically
(global-set-key (kbd "C-S-a") 'mark-whole-buffer)
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "C-y") 'scroll-up)
(global-set-key (kbd "C-S-y") 'scroll-down)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(load-theme 'monokai t)
