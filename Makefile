.PHONY: bootstrap
boostrap:
	./bootstrap.sh

.PHONY: secrets
	rsync -azvP ~/.ssh/config ~/.ssh/adityathebe desktop:~/.ssh/

