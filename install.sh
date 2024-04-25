#!/bin/bash

if ! command -v yay &> /dev/null; then
    echo "Installing yay package manager..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi
echo "welcome to the elite club"
echo "Installing required packages..."
yay -S --noconfirm asciinema btop cava code fish font-manager hypr kitty min nemo neofetch neovim ranger zatura spotify-tui swaylock waybar webcord wlogout wofi ytui_music

echo "Cloning configuration files repository..."
git clone <your_repository_url>
cd <repository_directory>

echo "copy your desire files manually"


echo "Configuration setup complete!"
echo "mozz mar bhai ab!"
