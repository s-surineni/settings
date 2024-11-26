* change `REPO_LOCATION` to the location where repo is cloned
* open `.zshrc` and add below block
``` shell
REPO_LOCATION=$HOME/ironman/settings


if [ -f $REPO_LOCATION/terminalconfig.sh ]; then
	. $REPO_LOCATION/terminalconfig.sh
fi
```
## tmux config
* put below in `~/.tmux.conf`

``` shell
source-file ~/ironman/settings/tmuxconfig.sh
```


# set -g default-shell /usr/bin/zsh
