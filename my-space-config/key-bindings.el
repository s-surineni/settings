;; (when (file-exists-p "/home/recorder/settings/my-space-config/key-bindings.el")
;;   (load-file "/home/recorder/settings/my-space-config/key-bindings.el")
;;   )
;; put this in user-config
;; movement bindings
(global-set-key (kbd "M-f") 'forward-char)
(global-set-key (kbd "M-b") 'backward-char)
(global-set-key (kbd "M-d") 'delete-char)

(global-set-key (kbd "C-b") 'backward-word)
(global-set-key (kbd "C-f") 'forward-word)
(global-set-key (kbd "C-d") 'sp-delete-word)
