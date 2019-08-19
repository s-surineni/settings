# put this in ~/.tmux.conf
# source-file ~/settings/tmuxconfig.sh
# set -g default-shell /usr/bin/zsh
set -g default-shell $SHELL
set -g prefix C-a

# # bind 'C-x C-x' to type 'C-x'
bind C-a send-prefix
set -g mouse on
set -g default-terminal "screen-256color"
set -g terminal-overrides 'xterm*:smcup@:rmcup@'
# # Use emacs keybindings for tmux commandline input.
# # (Note: if in vi mode, to get command mode you need to hit ESC twice.)
set -g status-keys emacs
# #cpy pste keys
set-window-option -g mode-keys emacs
# # Window management / navigation

# # move between windows
bind  C-b previous-window
bind  C-f next-window
bind  C-l last-window

# pane selection commands
bind  p select-pane -U
bind  n select-pane -D
bind  b select-pane -L
bind  f select-pane -R

unbind [
bind  C-w copy-mode
set-option -g history-limit 2000000
# bind -t vi-copy v begin-selection
# bind -t vi-copy y copy-selection
# bind -t vi-copy Escape cancel
# #bind -t vi-copy 'v' begin-selection
# #bind -t vi-copy 'y' copy-selection
# #set -g mode-mouse on
set -g @plugin 'tmux-plugins/tmux-yank'
set -g base-index 1
setw -g pane-base-index 1
# unbind-key -n C-r
bind r source-file ~/.tmux.conf \; display "Reloaded!"
bind  - split-window -v
bind  \ split-window -h
bind  C-r send-keys -R \; clear-history
# # List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
# close all tmux windows
# # move x clipboard into tmux paste buffer
# #bind C-p run "tmux set-buffer \"$(xclip -o)\"; tmux paste-buffer"
# # move tmux copy buffer into x clipboard
# #bind C-y run "tmux save-buffer - | xclip -i" 
run '~/.tmux/plugins/tpm/tpm'

bind X kill-server
