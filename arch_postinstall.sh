#!/bin/bash
NEW_USER=test
PREF_SHELL=zsh


############################
######### Packages #########
############################

# update all packages
pacman -Syu

# install some core utilities

core_utils=(
      amd-ucode # or intel-ucode if on intel cpu
      base-devel # package group with basic tools for compilation
      git
      vim
      neovim
      foot # terminal
      tmux
      stow # to install the dotfiles
      $PREF_SHELL
      zoxide # an improved cd command
      fzf # fuzzy finding
      fd # file finding
      ripgrep
      nodejs
      npm
      go
      unzip
      wl-clipboard # enabling nvim to work with the clipboard (or copy from files to clip)
      nerd-fonts # fancy icons
      rofi-wayland # used for an application launcher
      brightnessctl
      openssh
      wget
      fcitx5 # input method framework
      fcitx5-chinese-addons
      fcitx5-configtool
      nwg-look # gtk settings editor
      kvantum # qt theming engine
      qt6ct # qt configuration
      bluez # bluetooth
      bluez-utils
      qt5-wayland
      qt6-wayland
      gcr-4
      gnome-keyring
      pipewire
      wireplumber
      pipewire-audio
      pipewire-alsa
      pipewire-pulse
)


pacman -S "${core_utils[@]}"

# some useful user applications
pacman -S \
  firefox \
  yazi \
  spotify-launcher

# install hyprland and related tools
pacman -S \
  hyprland \
  hyprpaper \
  hyprlock \
  hypridle


# yay
git clone https://aur.archlinux.org/yay.git /opt/yay
cd /opt/yay
makepkg -si
cd

# quickshell
yay -S quickshell

# start some systemd units
systemctl enable --now bluetooth

############################
####### User Setup #########
############################

# create user and ask for password
useradd -m -G wheel $NEW_USER
passwd $NEW_USER

# enable sudo for wheel group
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/00-wheel-sudo
chmod 440 /etc/sudoers.d/00-wheel-sudo


