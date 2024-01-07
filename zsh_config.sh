plugins=(
    git
    zsh-autosuggestions
    virtualenv
)

ZSH_THEME="bira"
echo "loading for zshconfig"
source $ZSH/oh-my-zsh.sh

# echo "if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi" >> ~/.zshrc # add autocomplete permanently to your zsh shell
