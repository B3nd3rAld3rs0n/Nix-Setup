#!/bin/bash
# by Ahaupt3

# Colorization
GREEN='\033[0;1;32m'
YELLOW='\033[0;33m'

# Variables
SETUPDIR=$(pwd)
TOOLS=~/Tools
DIRS=("$TOOLS")

# Source Scripts
for SCRIPT in scripts/*; do
    source "$SCRIPT"
done

# Check if Root
if [[ $EUID -ne 0 ]]; then
    echo -e "${YELLOW}This script must be run as root!" 
    sudo ls > /dev/null
fi

# Check what Distro
for OS in $(lsb_release -i | grep ID | cut -d ":" -f 2); do
    if [[ "$OS" == @(Ubuntu|Kali) ]]; then
        echo -e "${GREEN}OS is: $OS"
    else
        echo -e "${GREEN}OS is: ${YELLOW}$OS"
    fi
done
echo -e ""

# Setup DIRS
echo -e "${GREEN}Creating Directories${YELLOW}"
for DIR in "${DIRS[@]}"; do
    if [ ! -d "$DIR" ]; then
        mkdir -p "$DIR" || exit
    fi
done
echo -e ""

# Update Packages
echo -e "${GREEN}Updating Packages${YELLOW}"
if [[ "$OS" == Ubuntu ]]; then
    sudo add-apt-repository universe
fi
sudo apt -q update
echo -e ""

# Link Python3/Pip3 to Python/Pip command
echo -e "${GREEN}Linking Python3/Pip3 to Python/Pip${YELLOW}"
sudo rm /usr/bin/python
sudo ln -s /usr/bin/python3 /usr/bin/python
sudo apt-get install -y -qq python3-pip  > /dev/null
sudo rm /usr/bin/pip
sudo ln -s /usr/bin/pip3 /usr/bin/pip
echo -e ""

# Install Tools
ohmyzsh
terminator
tweaks
nautilus
chrome
code
flameshot

# if [[ $(lsb_release -i | grep ID | cut -d ":" -f 2) == Ubuntu ]]; then
#     ubuntu
# elif [[ $(lsb_release -i | grep ID | cut -d ":" -f 2) == Kali ]]; then
#     kali
# else
#     :
# fi

# System Config
config

# Complete
echo -e "${GREEN}Nix-Setup complete, reboot to complete now or run 'source ~/.zshrc' until next reboot."
sudo chsh -s "$(which zsh)" "$USER"

exit 0