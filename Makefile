.PHONY: bootstrap
boostrap:
	./bootstrap.sh

.PHONY: secrets
secrets:
	rsync -azvP ~/.ssh/config ~/.ssh/adityathebe ~/.ssh/adityathebe.pub desktop:~/.ssh/
	rsync -azvP ~/.config/secrets ~/.config/
