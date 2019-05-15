#!/bin/bash

#Ubuntu package updates and installation
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove
sudo apt-get install -y vim i3 wget curl git build-essential make gcc linux-headers-$(uname -r) zsh fonts-powerline 

#install oh-my-zsh
if [ -d ~/.oh-my-zsh ]; then
    rm -rf ~/.oh-my-zsh
fi
sh -c "$(curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

$(grep 'export ZSH=' ~/.zshrc | sed s/\"//g)
export ZSH_CUSTOM=$ZSH/custom
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

#dotfiles re-installation
make all
