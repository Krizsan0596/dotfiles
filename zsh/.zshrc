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
eval $(thefuck --alias)
clear
neofetch
