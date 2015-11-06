tmux new-session -s development -n servers -d

tmux split-window -v -t development
tmux send-keys -t development:1.1 'sst' C-m
tmux send-keys -t development:1.2 'mst' C-m

tmux new-window -n client -t development
tmux send-keys -t development:2 'cs' C-m

tmux new-window -n workers -t development
tmux split-window -v -t development:3
tmux split-window -h -t development:3
tmux send-keys -t development:3.1 'mister' C-m
tmux send-keys -t development:3.2 'batch' C-m
tmux send-keys -t development:3.3 'worker' C-m

tmux new-window -n console -t development
tmux select-window -t development:4
tmux attach -t development

