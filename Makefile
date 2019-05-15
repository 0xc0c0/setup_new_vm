DIR=dotfiles

all:
	cp $(DIR)/.vimrc ~/.
	cp $(DIR)/.zshrc ~/.
	cp $(DIR)/.bashrc ~/.

update:
	cp ~/.vimrc $(DIR)/.
	cp ~/.zshrc $(DIR)/.
	cp ~/.bashrc $(DIR)/.
