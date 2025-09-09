#!/bin/bash

# Execute this script from your user's home directory!


############################
######## Dotfiles ##########
############################
git clone https://github.com/yaene/dotfiles.git 
cd dotfiles
stow tmux nvim zsh hyprland mako waybar rofi alacritty fontconfig

# default hyprland monitor config (change if needed)
echo "monitor = , preferred, auto, auto" > ~/.config/hypr/display-setup.conf

############################
######## NPM Setup #########
############################
mkdir -p ~/.npm-global/lib
npm config set prefix ~/.npm-global
echo "export PATH=~/npm-global/bin:$PATH" > ~/.zprofile

############################
######## ZSH Setup #########
############################
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
# install some zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# install pure theme
mkdir -p ~/.zsh
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

############################
####### Theme Setup ########
############################
# icon theme
git clone https://github.com/vinceliuice/Tela-icon-theme.git
./Tela-icon-theme/install.sh -c purple
rm -rf Tela-icon-theme

# install GTK themes
wget https://github.com/HyDE-Project/hyde-themes/raw/refs/heads/Tokyo-Night/Source/Gtk_TokyoNight.tar.gz 
mkdir -p ~/.themes
tar -xvzf Gtk_TokyoNight.tar.gz -C ~/.themes
rm Gtk_TokyoNight.tar.gz

# install Qt themes
mkdir -p ~/.config/Kvantum
git clone https://github.com/0xsch1zo/Kvantum-Tokyo-Night.git
mv ~/Kvantum-Tokyo-Night/Kvantum-Tokyo-Night ~/.config/Kvantum/

rm -rf Kvantum-Tokyo-Night

# now configure themes with qt6ct, kvantummanager, nwg-look

###########################
####### Spicetify #########
###########################

curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh


###########################
######## Ssh keyring ######
###########################
systemctl --user enable gcr-ssh-agent.socket
systemctl --user start gcr-ssh-agent.socket



