if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]
then
    echo "auto suggestions installed"
else
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

# after this do ctrl - a + I to install packages
if [ -d ~/.tmux/plugins/tpm ]
then
    echo "tmux package manager installed"
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

plugins=(
    git
    zsh-autosuggestions
)

ZSH_THEME="bira"
echo "loading for zshconfig"
source $ZSH/oh-my-zsh.sh
