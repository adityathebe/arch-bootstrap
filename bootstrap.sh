#!/bin/env bash

is_desktop=true
primary_monitor=DP-5

sudo pacman -Syu

echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDs5rFHygPS8uCK+LJ4XOpenVrGk6ZUzNLb6w9eFiUI8 adityathebe' >> ~/.ssh/authorized_keys

# Essentials
sudo pacman -S base-devel linux linux-headers linux-firmware zsh git neovim \
  pulseaudio curl numlockx cronie inetutils

# Install yay
git clone https://aur.archlinux.org/yay.gita --depth=1 /tmp/yay
cd /tmp/yay
makepkg -si
cd ~

# GUI
yay -S xorg-server xorg-init xorg-xrandr xclip bspwm pasystray \
  rofi sxhkd polybar dunst flameshot picom xset feh \
  redshift-gtk blueman-applet nm-applet mpv nemo alacritty \
  brave-bin visual-studio-code-bin slack-desktop seahorse \
  gnome-keyring seahorse lxappearance telegram-desktop

# CLI applications
yay -S tmux unzip go rust rust-analyzer newsboat bottom yazi wget \
  eza bat lsof atuin restic direnv zoxide fastfetch bandwhich less rsync \
  lazygit nix golangci-lint-bin jq yq aria2c
  
# Containers
yay -S fluxcd helm kubectl kubens kustomize docker docker-compose lazydocker

# Set zsh as the default shell
chsh -s $(which zsh)

if [ "$is_desktop" = false ]; THEN
  yay -S light
fi

###################
## Setup Configs
###################
git clone 'https://github.com/adityathebe/dotfiles' ~/dotfiles --depth=1
cp -r ~/dotfiles/.config/atuin ~/.config
cp -r ~/dotfiles/.config/bspwm ~/.config
cp -r ~/dotfiles/.config/dunst ~/.config
cp -r ~/dotfiles/.config/fastfetch ~/.config
cp -r ~/dotfiles/.config/git ~/.config
cp -r ~/dotfiles/.config/mpv ~/.config
cp -r ~/dotfiles/.config/newsboat ~/.config
cp -r ~/dotfiles/.config/rofi ~/.config
cp -r ~/dotfiles/.config/sxhkd ~/.config
cp -r ~/dotfiles/.config/yazi ~/.config

cp ~/dotfiles/.config/.aliases ~/.config/
cp ~/dotfiles/.config/env ~/.config/env
cp ~/dotfiles/.config/hacking_aliases.sh ~/.config/.aliases
cp ~/dotfiles/.config/kube_aliases.sh ~/.config/.aliases
cp ~/dotfiles/.config/redshift.conf ~/.config/
cp ~/dotfiles/.xinitrc ~/.xinitrc

# Alacritty
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes --depth=1

# Polybar
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
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm --depth=1

# Neovim
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim --depth=1
git clone https://github.com/adityathebe/astronvim ~/.config/nvim/lua/user

###################
## Fonts
###################
mkdir -p ~/.local/share/fonts

yay -S ttf-nerd-fonts-symbols

cd /tmp
wget 'https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip'
unzip fontawesome-free-5.15.4-desktop.zip -d ~/.local/share/fonts

wget 'https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip'
unzip JetBrainsMono-2.304.zip -d ~/.local/share/fonts/JetBrainsMono
cd ~

git clone 'https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts.git' ~/.local/share/fonts/SFPro --depth=1

fc-cache -f -v

#################
## Theme
#################
mkdir -p ~/.local/share/themes
wget https://github.com/EliverLara/Nordic/releases/download/v2.2.0/Nordic-darker.tar.xz -O /tmp
tar xf Nordic-darker.tar.xz -C ~/.local/share/themes/

xrandr --output $primary_monitor --mode 2560x1440 --rate 164.83

###################
## Services
###################
sudo systemctl start docker
sudo usermod -aG docker $USER

sudo systemctl start nix-daemon
sudo usermod -aG nix-users $USER

echo "========================"
echo "TODO"
echo "- Setup crontab"
echo "- Update nix channel"
echo "  nix-channel --update --verbose"
echo "- Initialize tmux tpm (Press prefix + I (capital i, as in Install) to fetch the plugin)"
echo "========================"
