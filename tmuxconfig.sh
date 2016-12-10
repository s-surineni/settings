
set -g prefix C-x

# # bind 'C-x C-x' to type 'C-x'
bind C-x send-prefix
set -g mouse on
set -g default-terminal "screen-256color"
set -g terminal-overrides 'xterm*:smcup@:rmcup@'
# # Use emacs keybindings for tmux commandline input.
# # (Note: if in vi mode, to get command mode you need to hit ESC twice.)
set -g status-keys emacs
# #cpy pste keys
set-window-option -g mode-keys vi
# # Window management / navigation

# # move between windows
bind -n C-b previous-window
bind -n C-f next-window
bind -n C-l last-window

# pane selection commands
bind -n M-p select-pane -U
bind -n M-n select-pane -D
bind -n M-b select-pane -L
bind -n M-f select-pane -R

unbind [
bind -n C-w copy-mode
bind -t vi-copy v begin-selection
bind -t vi-copy y copy-selection
bind -t vi-copy Escape cancel
# #bind -t vi-copy 'v' begin-selection
# #bind -t vi-copy 'y' copy-selection
# #set -g mode-mouse on
set -g @plugin 'tmux-plugins/tmux-yank'
set -g base-index 1
setw -g pane-base-index 1
# unbind-key -n C-r
bind r source-file ~/.tmux.conf \; display "Reloaded!"
bind -n C-h split-window -v
bind -n C-v split-window -h
bind  C-r send-keys -R \; clear-history
# # List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
# close all tmux windows
bind -n M-x kill-server
bind -n M-o new-window
# # move x clipboard into tmux paste buffer
# #bind C-p run "tmux set-buffer \"$(xclip -o)\"; tmux paste-buffer"
# # move tmux copy buffer into x clipboard
# #bind C-y run "tmux save-buffer - | xclip -i" 
run '~/.tmux/plugins/tpm/tpm'