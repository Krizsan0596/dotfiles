# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/krizsan/.zshrc'

autoload -Uz compinit promptinit
compinit
# End of lines added by compinstall
plugins=(zsh-autosuggestions zsh-syntax-highlighting you-should-use zsh-bat)
promptinit
PROMPT='%F{blue}┌─(%f%F{#FF272A}%n@%m%f%(1j.%F{#FF272A} [%j]%f.)%F{blue})[%~]%f
%F{blue}└─$%f '
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
clear
neofetch

eval $(thefuck --alias)
