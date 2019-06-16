DIR=dotfiles

all:
	cp $(DIR)/.vimrc ~/.
	cp $(DIR)/.zshrc ~/.
	cp $(DIR)/.bashrc ~/.
	mkdir -p ~/.config/i3/
	cp $(DIR)/.config/i3/* ~/.config/i3/.

update:
	cp ~/.vimrc $(DIR)/.
	cp ~/.zshrc $(DIR)/.
	cp ~/.bashrc $(DIR)/.
	cp ~/.config/i3/config $(DIR)/.config/i3/config
	cp ~/.config/i3/workspace-1_admin.json $(DIR)/.config/i3/workspace-1_admin.json
