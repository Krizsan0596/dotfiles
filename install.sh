#!/bin/bash
dotfiles="$(pwd)"
cd ~
echo "Setting up zsh, you will be asked for your sudo password a few times."
#Does user want to install for root too?
while true; do
read -p "Would you like to setup zsh for the root account too? [Y/n] >" for_root
if [ "${for_root^^}" = "Y" ] || [ "${for_root^^}" = "N" ]; then 
	break
else
	echo "Invalid input!"
fi
done

mv .zshrc .zshrc-backup

# Install yay
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# Install required packages using yay
yay -Syu --noconfirm stow zsh git curl bat neofetch thefuck
rm -rf yay

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Oh My Zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"
mkdir -p "${ZSH_CUSTOM}/plugins"

plugins=(
    "zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting"
    "you-should-use https://github.com/MichaelAquilina/zsh-you-should-use"
    "zsh-bat https://github.com/fdellwing/zsh-bat.git"
)

for plugin in "${plugins[@]}"; do
    name="${plugin%% *}"
    url="${plugin#* }"
    if [ ! -d "${ZSH_CUSTOM}/plugins/${name}" ]; then
        git clone --depth=1 "${url}" "${ZSH_CUSTOM}/plugins/${name}"
    fi
done

#Use Stow to symlink dotfiles
stow -d "${dotfiles}" -t ~ zsh

# Set zsh as default shell
if [ "$SHELL" != "$(command -v zsh)" ]; then
    chsh -s "$(command -v zsh)"
fi

#Setup zsh for root
if [ "${for_root^^}" = "Y" ]; then
	sudo cp "${dotfiles}/zsh/.zshrc" /root/.zshrc
	sed -i $d /root/.zshrc && sed -i $d /root/.zshrc && sed -i $d /root/.zshrc
echo "Installation complete! Please restart your terminal or run 'exec zsh'"
