					;emacs load paths
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized t)

;; Disable loading of “default.el” at startup,
(setq inhibit-default-init t)
;(setq solarized-scale-org-headlines nil)
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

					;(add-hook 'prog-mode-hook #'(lambda() (autopair-mode)));auto-pair

					;funtion definitions
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
                      (setq ξp2 (+ (line-end-position) 1))))))
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
    web-mode
    ))
(dolist (p tmtxt/packages)
  (when (not (package-installed-p p))
    (package-install p)))
(package-initialize)


(require 'aggressive-indent)
(global-aggressive-indent-mode 1)
					;(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
;; auto complete mod
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
					;auto complete
(add-to-list 'ac-modes 'org-mode);auto complete in org mode
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode));webmodeb

(require 'transpose-frame)

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

(setq py-install-directory "~/.emacs.d/lisp/")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)

;;tern mode
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))
;;tern mode

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)

(autopair-global-mode) ;; enable autopair in all buffers

;; ;;auto indent yanked test
;; (dolist (command '(yank yank-pop))
;;   (eval `(defadvice ,command (after indent-region activate)
;; 	   (and (not current-prefix-arg)
;; 		(member major-mode '(emacs-lisp-mode lisp-mode
;; 						     clojure-mode    scheme-mode
;; 						     haskell-mode    ruby-mode
;; 						     rspec-mode      python-mode
;; 						     c-mode          c++-mode
;; 						     objc-mode       latex-mode
;; 						     plain-tex-mode  web-mode))
;; 		(let ((mark-even-if-inactive transient-mark-mode))
;; 		  (indent-region (region-beginning) (region-end) nil))))))





					;(enable-theme 'solarized);theme enabling

;;;Prelude starts here

(defvar prelude-packages
  '(ack-and-a-half auctex clojure-mode coffee-mode deft expand-region
                   gist groovy-mode haml-mode haskell-mode inf-ruby
                   markdown-mode paredit projectile 
                   sass-mode rainbow-mode scss-mode volatile-highlights
		   yaml-mode yari )
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

(defun my-disable-electric-indent ()
  (set (make-local-variable 'electric-indent-mode) nil))

(auto-complete-mode 1)
;; (defun auto-complete-mode-maybe ()
;;   "No maybe for you. Only AC!"
;;   (unless (minibufferp (current-buffer))
;;     (auto-complete-mode 1)))
(setq ac-disable-faces nil)

(add-hook 'python-mode-hook (lambda () (electric-indent-local-mode -1)))
(add-hook 'python-mode-hook 'auto-indent-mode)

(global-set-key (kbd "C-l") 'goto-line) ; Ctrl+Shift+k
(global-set-key (kbd "M-S-d") 'my-delete-line-backward) ; Ctrl+Shift+k
(global-set-key (kbd "M-d") 'my-delete-line)
(global-set-key (kbd "C-d") 'my-delete-word)
(global-set-key (kbd "C-S-d") 'my-backward-delete-word)
(global-set-key (kbd "<M-backspace>") 'my-backward-delete-word)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-/") 'other-window)

(global-set-key (kbd "<f2>") 'xah-cut-line-or-region) ; cut
(global-set-key (kbd "<f3>") 'xah-copy-line-or-region) ; copy
					;(global-set-key (kbd "C-c") 'my-kill-ring-save) ; copy
;(global-set-key (kbd "C-x") 'kill-region) ; copy
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(cursor-type (quote bar))
 '(custom-enabled-themes (quote (solarized)))
 '(custom-safe-themes
   (quote
    ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(desktop-save-mode t)
 '(fci-rule-color "#eee8d5")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(initial-frame-alist (quote ((vertical-scroll-bars) (fullscreen . maximized))))
 '(kill-whole-line t)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
