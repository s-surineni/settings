if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]
then
    echo "auto suggestions installed"
else
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

plugins=(
    git
    zsh-autosuggestions
)

ZSH_THEME="bira"
echo "loading for zshconfig"
source $ZSH/oh-my-zsh.sh
