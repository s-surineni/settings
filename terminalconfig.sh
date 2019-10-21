#!/bin/bash
# place this in .bashrc
# if [ -f ~/settings/terminalconfig.sh ]; then
# 	. ~/settings/terminalconfig.sh
# fi
REPO_LOCATION=~/sampath/settings
export HISTSIZE=1000000
export HISTFILESIZE=1000000000

# Source global definitions
if [ -f $REPO_LOCATION/aliases.sh ]; then
	. $REPO_LOCATION/aliases.sh
fi

# Source global definitions
if [ -f $REPO_LOCATION/paths.sh ]; then
	. $REPO_LOCATION/paths.sh
fi

. $REPO_LOCATION/zsh_config.sh

. $REPO_LOCATION/org_specific.sh


source /usr/local/bin/virtualenvwrapper.sh
