.PHONY: bootstrap
boostrap:
	./bootstrap.sh

.PHONY: secrets
secrets:
	rsync -azvP ~/.ssh/config ~/.ssh/adityathebe desktop:~/.ssh/
	rsync -azvP ~/.config/secrets ~/.config/
