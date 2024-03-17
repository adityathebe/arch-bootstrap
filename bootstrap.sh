#!/bin/env bash

is_desktop=true

mkdir -p ~/.local/bin
mkdir -p ~/.local/share/fonts

sudo pacman -Syu

# Essentials
sudo pacman -S base-devel linux linux-headers linux-firmware zsh git neovim \
  pulseaudio 

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# GUI
sudo pacman -S xorg-server xorg-init xorg-xrandr bspwmpasystray \
  rofi sxhkd polybar dunst flameshot picom xset feh \
  redshift-gtk blueman-applet nm-applet 

# User applications
yay pacman -S tmux unzip go numlockx newsboat bottom \
  eza bat lsof atuin restic nemo direnv zoxide fastfetch \
  bandwhich alacritty brave-bin visual-studio-code-bin

# Kubernetes
yay -S flux helm kubectl

# Set zsh as the default shell
chsh -s $(which zsh)

if [ "$is_desktop" = false ]; THEN
  yay -S light
fi

###################
## Setup Configs
###################
git clone 'https://github.com/adityathebe/dotfiles' ~/dotfiles
cp -r ~/dotfiles/.config/bspwm ~/.config
cp -r ~/dotfiles/.config/git ~/.config
cp -r ~/dotfiles/.config/newsboat ~/.config
cp -r ~/dotfiles/.config/polybar ~/.config
cp -r ~/dotfiles/.config/rofi ~/.config
cp -r ~/dotfiles/.config/tmux ~/.config
cp -r ~/dotfiles/.config/zsh ~/.config

cp ~/dotfiles/.config/.aliases ~/.config/.aliases
cp ~/dotfiles/.config/kube_aliases.sh ~/.config/.aliases
cp ~/dotfiles/.config/hacking_aliases.sh ~/.config/.aliases
cp ~/dotfiles/.config/env ~/.config/env

cp ~/dotfiles/.xinitrc ~/.xinitrc
cp -r ~/dotfiles/.local/bin/statusbar ~/.local/bin/

# Neovim
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
git clone https://github.com/adityathebe/astronvim ~/.config/nvim/lua/user

###################
## Fonts
###################
yay -S ttf-font-awesome

wget 'https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip' /tmp/
unzip /tmp/JetBrainsMono-2.304.zip -d ~/.local/share/fonts/JetBrainsMono
fc-cache -f -v
