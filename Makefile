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
	cp ~/.config/i3/config $(DIR)/.config/i3/config
	cp ~/.config/i3/workspace-admin_quad_nautilus.json $(DIR)/.config/i3/workspace-admin_quad_nautilus.json

.PHONY: diff
diff:
	diff $(DIR)/.vimrc ~/. || echo "differences with .vimrc"
	diff $(DIR)/.zshrc ~/. || echo "differences with .zshrc"
	diff $(DIR)/.bashrc ~/. || echo "differences with .bashrc"
	diff $(DIR)/.aliases ~/.aliases || echo "differences with .aliases"
	diff $(DIR)/.config/i3/config ~/.config/i3/config || echo "differences with i3 config"
	diff $(DIR)/.config/i3/workspace-admin_quad_nautilus.json ~/.config/i3/workspace-admin_quad_nautilus.json || echo "differences with workspace-admin_quad_nautilus.json"

