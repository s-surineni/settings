echo "loading terminalconfig.sh "
export HISTSIZE=1000000
export HISTFILESIZE=1000000000

# Source global definitions
if [ -f $REPO_LOCATION/aliases.sh ]; then
	. $REPO_LOCATION/aliases.sh
fi

. $REPO_LOCATION/zsh_config.sh

