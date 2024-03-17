#!/bin/env bash

is_desktop=true
primary_monitor=DP-5

sudo pacman -Syu

# Essentials
sudo pacman -S base-devel linux linux-headers linux-firmware zsh git neovim \
  pulseaudio curl

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# GUI
yay -S xorg-server xorg-init xorg-xrandr xclip bspwm pasystray \
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
git clone https://github.com/romkatv/powerlevel10k.git ~/.local/share/zsh/powerlevel10k --depth=1 
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.local/share/zsh/oh-my-zsh --depth=1
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.local/share/zsh/plugins/zsh-autosuggestions --depth=1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.local/share/zsh/plugins/zsh-syntax-highlighting --depth=1
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ~/.local/share/zsh/plugins/you-should-use --depth=1

# Tmux
cp -r ~/dotfiles/.config/tmux ~/.config
git clone https://github.com/tmux-plugins/tmux-sensible ~/.config/tmux/plugins/tmux-sensible --depth=1

# Neovim
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim --depth=1
git clone https://github.com/adityathebe/astronvim ~/.config/nvim/lua/user

###################
## Fonts
###################
mkdir -p ~/.local/share/fonts

yay -S ttf-font-awesome ttf-nerd-fonts-symbols noto-fonts

wget 'https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip' /tmp/
unzip /tmp/JetBrainsMono-2.304.zip -d ~/.local/share/fonts/JetBrainsMono
fc-cache -f -v

xrandr --output $primary_monitor --mode 2560x1440 --rate 164.83
