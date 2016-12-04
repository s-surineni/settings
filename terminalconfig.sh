export HISTSIZE=1000000
export HISTFILESIZE=1000000000
# code to show git branch in prompt
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="[\w]\$(parse_git_branch)\n\\$ \[$(tput sgr0)\]"
