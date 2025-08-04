#!/bin/bash

# Install required packages using yay
sudo yay -Syu --noconfirm zsh git curl bat neofetch python-pip

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Oh My Zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"
mkdir -p "${ZSH_CUSTOM}/plugins"

plugins=(
    "zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting"
    "you-should-use https://github.com/MichaelAquilina/zsh-you-should-use"
    "zsh-bat https://github.com/eth-p/zsh-bat"
)

for plugin in "${plugins[@]}"; do
    name="${plugin%% *}"
    url="${plugin#* }"
    if [ ! -d "${ZSH_CUSTOM}/plugins/${name}" ]; then
        git clone --depth=1 "${url}" "${ZSH_CUSTOM}/plugins/${name}"
    fi
done

# Install thefuck
pip install --user thefuck

# Create a clean .zshrc configuration
cat > ~/.zshrc << 'EOF'
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(zsh-autosuggestions zsh-syntax-highlighting you-should-use zsh-bat)
source "$ZSH/oh-my-zsh.sh"

# Original customizations
PROMPT='%F{blue}┌─(%f%F{#FF272A}%n@%m%f%(1j.%F{#FF272A} [%j]%f.)%F{blue})[%~]%f
%F{blue}└─$%f '
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
clear
neofetch

eval $(thefuck --alias)
EOF

# Set zsh as default shell
if [ "$SHELL" != "$(command -v zsh)" ]; then
    chsh -s "$(command -v zsh)"
fi

echo "Installation complete! Please restart your terminal or run 'exec zsh'"
