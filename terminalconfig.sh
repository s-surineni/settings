export HISTSIZE=1000000
export HISTFILESIZE=1000000000

export PATH=/Applications/MacPorts/EmacsMac.app/Contents/MacOS/bin:$PATH # only for mac
# Source global definitions
if [ -f $REPO_LOCATION/aliases.sh ]; then
	. $REPO_LOCATION/aliases.sh
fi

# Source global definitions
if [ -f $REPO_LOCATION/paths.sh ]; then
	. $REPO_LOCATION/paths.sh
fi

. $REPO_LOCATION/zsh_config.sh
