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
yay -S --noconfirm asciinema btop cava code fish font-manager hypr kitty min nemo neofetch neovim ranger zathura spotify-tui swaylock waybar webcord wlogout wofi ytui_music firefox

echo "Cloning configuration files repository..."
git clone <your_repository_url>
cd <repository_directory>

echo "copy your desire files manually"
echo "installing fonts"
read -p "Do you want to install additional fonts for Processing? (Y/N): " choice

if [[ $choice == [Yy] ]]; then
    echo "Installing additional fonts for Processing..."
    
    sudo pacman -S --noconfirm noto-fonts adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts ttf-hanazono noto-fonts-emoji noto-fonts-emoji-apple ttf-dejavu ttf-liberation
    
    fc-cache -fv
   
    echo "Additional fonts installed successfully."
elif [[ $choice == [Nn] ]]; then
    echo "Skipping additional fonts installation."
else
    echo "Invalid choice. Please enter Y or N."
fi


echo "Configuration setup complete!"
echo "mozz mar bhai ab!"
