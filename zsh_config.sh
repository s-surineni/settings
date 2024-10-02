plugins=(
    git
    zsh-autosuggestions
    virtualenv
)

ZSH_THEME="bira"

function acp() {
    git commit -m "$1"
    git push origin HEAD
}

source $ZSH/oh-my-zsh.sh


