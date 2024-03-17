#!/bin/env bash

is_desktop=true

sudo pacman -Syu

# Essentials
sudo pacman -S base-devel linux linux-headers linux-firmware zsh git neovim \
  pulseaudio curl

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# GUI
yay -S xorg-server xorg-init xorg-xrandr bspwm pasystray \
  rofi sxhkd polybar dunst flameshot picom xset feh \
  redshift-gtk blueman-applet nm-applet 

# User applications
yay -S tmux unzip go numlockx newsboat bottom yazi mpv wget \
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
cp -r ~/dotfiles/.config/rofi ~/.config

cp ~/dotfiles/.config/.aliases ~/.config/.aliases
cp ~/dotfiles/.config/env ~/.config/env
cp ~/dotfiles/.config/hacking_aliases.sh ~/.config/.aliases
cp ~/dotfiles/.config/kube_aliases.sh ~/.config/.aliases
cp ~/dotfiles/.xinitrc ~/.xinitrc

# Polybar
cp -r ~/dotfiles/.config/polybar ~/.config
mkdir -p ~/.local/bin
cp -r ~/dotfiles/.local/bin/statusbar ~/.local/bin/

# zsh
cp -r ~/dotfiles/.config/zsh ~/.config
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.local/share/oh-my-zsh

# Tmux
cp -r ~/dotfiles/.config/tmux ~/.config
git clone https://github.com/tmux-plugins/tmux-sensible ~/.config/tmux/plugins/tmux-sensible

# Neovim
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
git clone https://github.com/adityathebe/astronvim ~/.config/nvim/lua/user

###################
## Fonts
###################
mkdir -p ~/.local/share/fonts

yay -S ttf-font-awesome ttf-nerd-fonts-symbols noto-fonts

wget 'https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip' /tmp/
unzip /tmp/JetBrainsMono-2.304.zip -d ~/.local/share/fonts/JetBrainsMono
fc-cache -f -v
