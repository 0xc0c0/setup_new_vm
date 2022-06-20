# Recommended Installation
`sudo apt-get install -y curl`\
`bash -c "$(curl https://raw.githubusercontent.com/0xc0c0/setup_new_vm/master/setup.sh)"`

## setup.sh
script to run on new Ubuntu 18.04 installation:
  - installs tools to build kernel modules for upgrading VirtualBox Guest Additions
  - installs i3
  - updates system to the distro's latest
  - installs oh-my-zsh & some decent themes
  - installs decent dotfiles (per this repo)

## dotfiles
Installs dotfiles via [here](https://raw.githubusercontent.com/0xc0c0/dotfiles/master/.dotfiles_other/setup.sh)

## How an external user can then migrate to their own dotfiles 

First login to github and create your own **dotfiles** repo there.  Then update the git repo to your repo with

```
dotfiles config --local remote.origin.url https://github.com/<user>/dotfiles.git
```

Display all files

```
dotfiles status -u
```

Add files you care to add

```
dotfiles add <files>
```

Commit and push

```
dotfiles commit -am 'updated files'
dotfiles push
```

Enjoy!
