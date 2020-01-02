#!/bin/bash

#check sudo
if [[ $(id -u) == "0" ]]; then
    echo "script intended to be run as a normal user, not root. exiting..."
    exit 99
fi

echo "sudo permissions required for installations to run, checking..."
sudo -v
if [[ "$?" != "0" ]]; then
    echo "sudo attempt failed."
else
    echo "updating system via APT and installing several baseline packages for this installation..."
    sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove
    sudo apt-get install vim wget curl git build-essential make gcc linux-headers-$(uname -r)
fi

#Ubuntu package updates and installation
echo "Install i3? (default=No, enter 'Yes' for yes)"
read input
if [[ $input == "Yes" ]]; then
    echo "Installing i3..."
    sudo apt-get update && sudo apt-get install -y i3 gnome pianobar

else
    echo "Skipping i3 installation..."
fi


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
echo "Setup oh-my-zsh? (default=No, enter 'Yes' for yes)"
read input
if [[ $input == "Yes" ]]; then
    if [ -d ~/.oh-my-zsh ]; then
        rm -rf ~/.oh-my-zsh
    fi
    sudo apt-get install zsh fonts-powerline
    sh -c "$(curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    $(grep 'export ZSH=' ~/.zshrc | sed s/\"//g)
    export ZSH_CUSTOM=$ZSH/custom
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

echo "Install dotfiles? (default=No, enter 'Yes' for yes)"
read input
if [[ $input == "Yes" ]]; then
    #dotfiles installation
    if [[ -d .git ]] && [[ "$(cat .git/config)" =~ 'c0c0-work/setup_new_vm.git' ]]; then
        #the repo was already cloned before this file was run
        make install
    else
        #this file was run using a piped shell command, need the repo now
        git clone https://github.com/c0c0-work/setup_new_vm.git ~/.local/setup_new_vm
        cd ~/.local/setup_new_vm
        make install
        cd -
    fi
fi

echo "Setup gnome-terminal config? (default=No, enter 'Yes' for yes)"
read input
if [[ $input == "Yes" ]]; then
    sudo apt-get install gnome-terminal

    #gnome-terminal settings update
    if [ -f "$(which gsettings)" ]; then
        echo "Update terminal config settings for DejaVu Sans Mono and update colors to dark theme? (Need 'Yes' to confirm: "
        read input
        if [[ $input == 'Yes' ]]; then
            echo "Please enter your desired font size: (default=12)"
            read input
                if [[ ! $input =~ ^[[:digit:]]+$ ]]; then
                    input=12
                fi
                profile=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')
                dconf write /org/gnome/terminal/legacy/profiles:/:$profile/font "'DejaVu Sans Mono $input'"
                #gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" font "'DejaVu Sans Mono $input"
                #gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" use-system-font false
                dconf write /org/gnome/terminal/legacy/profiles:/:$profile/use-system-font 'false'
                dconf write /org/gnome/terminal/legacy/profiles:/:$profile/use-theme-colors 'false'
                dconf write /org/gnome/terminal/legacy/profiles:/:$profile/foreground-color "'rgb(211,215,207)'"
                dconf write /org/gnome/terminal/legacy/profiles:/:$profile/background-color "'rgb(46,52,54)'"
                dconf write /org/gnome/terminal/legacy/profiles:/:$profile/audible-bell 'false'
        fi
    fi
fi
