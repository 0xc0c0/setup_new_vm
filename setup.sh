#!/bin/bash

#Ubuntu package updates and installation
sudo apt-get update && sudo apt-get install -y vim i3 gnome wget curl git build-essential make gcc linux-headers-$(uname -r) zsh fonts-powerline pianobar
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove

#check if VM will be managing libvirt backend
echo "Install libvirt client-side tools? (default=No, enter 'Yes' for yes)"
read input
if [[ $input == "Yes" ]]; then
    echo "Installing libvirt client-side tools..."
    sudo apt-get install libvirt-clients virtinst
else
    echo "Skipping libvirt client-side tools..."
fi

#check if user wants slack & discord installed
echo "Install slack & discord apps? (default=No, enter 'Yes' for yes)"
read input
if [[ $input == "Yes" ]]; then
    echo "Installing slack..."
    sudo snap install --classic slack
    echo "Installing discord..."
    sudo snap install discord
else
    echo "Skipping slack & discord..."
fi

#install oh-my-zsh
if [ -d ~/.oh-my-zsh ]; then
    rm -rf ~/.oh-my-zsh
fi
sh -c "$(curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

$(grep 'export ZSH=' ~/.zshrc | sed s/\"//g)
export ZSH_CUSTOM=$ZSH/custom
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

#dotfiles installation
if [[ -d .git ]] && [[ "$(cat .git/config)" =~ 'c0c0-work/setup_new_vm.git' ]]; then
    #the repo was already cloned before this file was run
    make all
else
    #this file was run using a piped shell command, need the repo now
    git clone https://github.com/c0c0-work/setup_new_vm.git ~/.local/setup_new_vm
    cd ~/.local/setup_new_vm
    make all
    cd -
fi

#gnome-terminal settings update
if [ -f "$(which gsettings)" ]; then
    echo "Update terminal config settings for DejaVu Sans Mono? Need 'Yes' to confirm: "
    read input
    if [[ $input == 'Yes' ]]; then
        echo "Please enter your desired font size: (default=12)"
        read input
            if [[ ! $input =~ ^[[:digit:]]+$ ]]; then
                input = 12
            fi
            profile=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')
            gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" font 'DejaVu Sans Mono 9'
            gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" use-system-font false
    fi
fi
