#!/bin/bash

postconfig(){
    echo -e "${GREEN}Post-Configuration${YELLOW}"
    echo -e ""

    echo -e "${GREEN}Disabling Wayland${YELLOW}"
    sudo sed -i "s/\#Wayland/Wayland/" /etc/gdm3/custom.conf > /dev/null || sudo sed -i "s/\#Wayland/Wayland/" /etc/gdm3/daemon.conf > /dev/null
    echo -e ""

    # Set Nautilus settings
    # - gsettings list-keys org.gnome.Terminal.ProfilesList
    # - gsettings list-recursively org.gnome.Terminal.ProfilesList
    # - gsettings get org.gnome.Terminal.ProfilesList list
    # - gsettings set SCHEMA[:PATH] KEY VALUE

    # if [ $(lsb_release -i | grep ID | cut -d ":" -f 2) == Ubuntu ]; then
    #     Set Ubuntu config
    # else
    #     :
    # fi

    echo -e "${GREEN}Purging unused packages${YELLOW}"
    sudo apt purge --autoremove -y
    echo -e ""

    echo -e "${GREEN}Updating PATH${YELLOW}"
    echo -e "\n# Add to PATH" >> "$ZSHRC"
    echo -e 'export PATH="${PATH}":$(ls -d ~/Tools/* | tr "\\n" ":" | sed "s/:$//")' >> $ZSHRC
    echo -e ""

    echo -e "${GREEN}Finished Post-Configuration"
    echo -e ""
    
    return 0
}
