DIR=dotfiles

.PHONY: install
install:
	cp $(DIR)/.vimrc ~/.
	cp $(DIR)/.zshrc ~/.
	cp $(DIR)/.bashrc ~/.
	cp $(DIR)/.aliases ~/.aliases
	mkdir -p ~/.config/i3/
	cp $(DIR)/.config/i3/* ~/.config/i3/.

.PHONY: update
update:
	cp ~/.vimrc $(DIR)/.
	cp ~/.zshrc $(DIR)/.
	cp ~/.bashrc $(DIR)/.
	cp ~/.aliases $(DIR)/.
	cp ~/.config/i3/* $(DIR)/.config/i3/.

.PHONY: diff
diff:
	diff $(DIR)/.vimrc ~/. || echo "differences with .vimrc"
	diff $(DIR)/.zshrc ~/. || echo "differences with .zshrc"
	diff $(DIR)/.bashrc ~/. || echo "differences with .bashrc"
	diff $(DIR)/.aliases ~/.aliases || echo "differences with .aliases"
	for fnam in $$(ls $(DIR)/.config/i3/); do \
		diff $(DIR)/.config/i3/$${fnam} ~/.config/i3/$${fnam} || echo "differences with $${fnam}" ; \
	done

