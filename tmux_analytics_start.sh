tmux new -s analytics_server -d
tmux send-keys -t analytics_server 'cd ~/projects/aviso/analytics-server' C-m
tmux send-keys -t analytics_server 'source env/bin/activate' C-m
tmux send-keys -t analytics_server './g runserver'  C-m

tmux split-window -v -t analytics_server

tmux select-window -t analytics_server:1
tmux send-keys -t analytics_server 'cd ~/projects/aviso/analytics-server/welcome/' C-m
nvm use 12.10.0
tmux send-keys -t analytics_server 'npm run dev-hot'  C-m

tmux split-window -h -t analytics_server
tmux select-window -t analytics_server:3
tmux send-keys -t analytics_server 'cd ~/projects/aviso/analytics-server/welcome/static/js/' C-m
nvm use 12.10.0
tmux send-keys -t analytics_server 'node napp.js' C-m

tmux new-window -t analytics_server
tmux rename-window -t analytics_server collaboration
tmux send-keys -t analytics_server 'cd ~/projects/aviso/service-infrastructure' C-m
tmux send-keys -t analytics_server 'source ~/projects/aviso/service-infrastructure/vservenv/bin/activate' C-m
tmux send-keys -t analytics_server './collab' C-m
tmux attach -t analytics_server


