# if [ -f ~/myconfig/terminalconfig.sh ]; then
# 	. ~/myconfig/terminalconfig.sh
# fi
# path settings

export JAVA_HOME="/usr/java/jdk1.8.0_111"
export GRADLE_HOME="~/software/installed/gradle-3.2.1"
PATH="$GRADLE_HOME/bin:$PATH"
PATH="~/software/installed/apache-maven-3.3.9/bin:$PATH"

export HISTSIZE=1000000
export HISTFILESIZE=1000000000
# code to show git branch in prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
COLOR1="\[\033[1;33m\]"     #First color
COLOR2="\[\033[0;33m\]"     #Second color
# export PS1="${COLOR1}[\w]\$(parse_git_branch)\n\\$ \[$(tput sgr0)\]"
PS1="\[\e[1;33m\]\w\$(parse_git_branch)\n\$\[\e[0m\] "

# aliases
alias idea="~/software/idea-IC-163.7743.44/bin/idea.sh &"

# Source global definitions
if [ -f ~/settings/aliases.sh ]; then
	. ~/settings/aliases.sh
fi
