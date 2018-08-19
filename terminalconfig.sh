# place this in .bashrc
# if [ -f ~/settings/terminalconfig.sh ]; then
# 	. ~/settings/terminalconfig.sh
# fi

export HISTSIZE=1000000
export HISTFILESIZE=1000000000

# Source global definitions
if [ -f ~/settings/aliases.sh ]; then
	. ~/settings/aliases.sh
fi

# Source global definitions
if [ -f ~/settings/paths.sh ]; then
	. ~/settings/paths.sh
fi

source ~/settings/zsh_config.sh
