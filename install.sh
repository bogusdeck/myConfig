#!/bin/bash

set -e  # Exit on error

if ! command -v yay &> /dev/null; then
    echo "Installing yay package manager..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
else
    echo "yay is already installed."
fi

echo "Welcome to the elite club!"
echo "Updating system and installing required packages..."

yay -Syu --noconfirm
yay -S --noconfirm asciinema btop cava code fish font-manager hyprland kitty nemo neofetch neovim ranger zathura spotify-tui swaylock waybar webcord wlogout wofi ytui_music firefox alacritty rofi dunst ttf-hack-nerd ttf-iosevka-nerd noto-fonts-emoji adobe-source-han-sans-otc-fonts pipewire-pulse playerctl

echo "Cloning configuration files repository..."
git clone <your_repository_url> ~/dotfiles
cd ~/dotfiles

echo "Copying configuration files..."
cp -r ./config/* ~/.config/
cp -r ./local/* ~/.local/
cp -r ./fonts/* ~/.fonts/

echo "Reloading font cache..."
fc-cache -fv

echo "Configuring fish as default shell..."
if grep -Fxq "/usr/bin/fish" /etc/shells; then
    chsh -s /usr/bin/fish || echo "Failed to set fish as default shell. Run 'chsh -s /usr/bin/fish' manually."
else
    echo "/usr/bin/fish" | sudo tee -a /etc/shells
    chsh -s /usr/bin/fish || echo "Failed to set fish as default shell. Run 'chsh -s /usr/bin/fish' manually."
fi

echo "Setting up Hyprland..."
mkdir -p ~/.config/hypr
cp ./hyprland.conf ~/.config/hypr/

echo "Setting up Firefox custom theme..."
if [[ -d ~/.mozilla/firefox ]]; then
    echo "Installing Firefox userChrome.css..."
    FIREFOX_PROFILE=$(find ~/.mozilla/firefox -name "*.default-release" | head -n 1)
    if [[ -n $FIREFOX_PROFILE ]]; then
        mkdir -p "$FIREFOX_PROFILE/chrome"
        cp ./firefox/userChrome.css "$FIREFOX_PROFILE/chrome/"
    else
        echo "No default Firefox profile found."
    fi
else
    echo "Firefox is not installed or configured yet."
fi

echo "Installing fonts..."
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

echo "Setup complete! Please restart your session to apply all changes."
echo "mozz mar bhai ab!"
