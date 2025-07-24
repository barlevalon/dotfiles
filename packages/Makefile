.PHONY: save install

save:
	@echo "Saving package list..."
	@yay -Qqe > packages.txt
	@echo "Saved $$(wc -l < packages.txt) packages"

install:
	@echo "Installing packages..."
	@yay -S --needed - < packages.txt

update: save
	@git add packages.txt
	@git commit -m "Update package lists" || true