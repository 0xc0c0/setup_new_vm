#!/bin/bash

#Ubuntu package updates and installation
sudo apt-get update && sudo apt-get install -y vim i3 wget curl git build-essential make gcc linux-headers-$(uname -r) zsh fonts-powerline libvirt-clients
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove

#check if VM will be managing libvirt backend
echo "Install libvirt client-side tools? (default=No, enter 'Yes' for yes)"
read input
if [[ $input == "Yes" ]]; the
    echo "Installing libvirt client-side tools..."
    sudo apt-get install libvirt-clients virtinst
else
    echo "Skipping libvirt client-side tools..."
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
if [ $(pwd) == ~/.local/setup_new_vm ]; then
    #the repo was already cloned before this file was run
    make all
else
    #this file was run using a piped shell command, need the repo now
    git clone https://github.com/benchillingt/setup_new_vm ~/.local/setup_new_vm
    cd ~/.local/setup_new_vm
    make all
    cd -
fi

    
