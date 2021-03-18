* change `REPO_LOCATION` to the location where repo is cloned
* open `.zshrc` and add below block
``` shell
REPO_LOCATION=/Users/ssurineni/ironman/settings
. $REPO_LOCATION/terminalconfig.sh
```

# put this in ~/.tmux.conf
# source-file ~/settings/tmuxconfig.sh
# set -g default-shell /usr/bin/zsh