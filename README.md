# Recommended Installation
`sudo apt-get install curl`\
`bash -c "$(curl https://raw.githubusercontent.com/c0c0-work/setup_new_vm/master/setup.sh)"`

## setup.sh
script to run on new Ubuntu 18.04 installation:
  - installs tools to build kernel modules for upgrading VirtualBox Guest Additions
  - installs i3
  - updates system to the distro's latest
  - installs oh-my-zsh & some decent themes
  - installs decent dotfiles (per this repo)

## dotfiles
dotfiles basic install & update via the Makefile

### install
`make` or `make all`

### update local repo files from your active dotfiles in your ~/ directory
`make update`

