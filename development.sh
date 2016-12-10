tmux new-session -s development -n servers -d

tmux send-keys -t development:1 'sst' C-m

tmux new-window -n workers -t development
tmux split-window -v -t development:2
tmux split-window -h -t development:2
tmux send-keys -t development:2.1 'mister' C-m
tmux send-keys -t development:2.2 'batch' C-m
tmux send-keys -t development:2.3 'worker' C-m

tmux new-window -n client -t development
tmux send-keys -t development:3 'cs' C-m

tmux new-window -n mongo -t development
tmux send-keys -t development:4 'mongo gnana' C-m

tmux new-window -n webpack -t development
tmux send-keys -t development:5 'cd /home/sampath/projects/analytics-server/welcome' C-m
tmux send-keys -t development:5 'npm run dev-hot' C-m

tmux new-window -n console -t development
tmux select-window -t development:6
tmux attach -t development

