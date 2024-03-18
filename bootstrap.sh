#!/bin/env bash

is_desktop=true
primary_monitor=DP-5

sudo pacman -Syu

echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDs5rFHygPS8uCK+LJ4XOpenVrGk6ZUzNLb6w9eFiUI8 adityathebe' >> ~/.ssh/authorized_keys

# Essentials
sudo pacman -S base-devel linux linux-headers linux-firmware zsh git neovim \
  pulseaudio curl numlockx 

# Install yay
git clone https://aur.archlinux.org/yay.gita --depth=1 /tmp/yay
cd /tmp/yay
makepkg -si
cd ~

# GUI
yay -S xorg-server xorg-init xorg-xrandr xclip bspwm pasystray \
  rofi sxhkd polybar dunst flameshot picom xset feh \
  redshift-gtk blueman-applet nm-applet mpv nemo alacritty \
  brave-bin visual-studio-code-bin slack-desktop \
  gnome-keyring seahorse lxappearance telegram-desktop

# CLI applications
yay -S tmux unzip go rust rust-analyzer newsboat bottom yazi wget \
  eza bat lsof atuin restic direnv zoxide fastfetch bandwhich less rsync \
  lazygit
  
# Containers
yay -S flux helm kubectl docker docker-compose lazydocker

# Set zsh as the default shell
chsh -s $(which zsh)

if [ "$is_desktop" = false ]; THEN
  yay -S light
fi

###################
## Setup Configs
###################
git clone 'https://github.com/adityathebe/dotfiles' ~/dotfiles --depth=1
cp -r ~/dotfiles/.config/bspwm ~/.config
cp -r ~/dotfiles/.config/fastfetch ~/.config
cp -r ~/dotfiles/.config/git ~/.config
cp -r ~/dotfiles/.config/newsboat ~/.config
cp -r ~/dotfiles/.config/rofi ~/.config

cp ~/dotfiles/.config/.aliases ~/.config/.aliases
cp ~/dotfiles/.config/env ~/.config/env
cp ~/dotfiles/.config/hacking_aliases.sh ~/.config/.aliases
cp ~/dotfiles/.config/kube_aliases.sh ~/.config/.aliases
cp ~/dotfiles/.xinitrc ~/.xinitrc

# Alacritty
cp -r ~/dotfiles/.config/alacritty ~/.config
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes --depth=1

# Polybar
cp -r ~/dotfiles/.config/polybar ~/.config
mkdir -p ~/.local/bin
cp -r ~/dotfiles/.local/bin/statusbar ~/.local/bin/

# zsh
cp -r ~/dotfiles/.config/zsh/* ~/.config
git clone https://github.com/romkatv/powerlevel10k.git ~/.local/share/zsh/powerlevel10k --depth=1 
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

#################
## Theme
#################
mkdir -p ~/.local/share/themes
wget https://github.com/EliverLara/Nordic/releases/download/v2.2.0/Nordic-darker.tar.xz -O /tmp
tar xf Nordic-darker.tar.xz -C ~/.local/share/themes/

xrandr --output $primary_monitor --mode 2560x1440 --rate 164.83
