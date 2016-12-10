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
