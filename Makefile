.PHONY: bootstrap
boostrap:
	./bootstrap.sh

.PHONY: secrets
secrets:
	rsync -azvP ~/.ssh/config ~/.ssh/adityathebe ~/.ssh/adityathebe.pub desktop:~/.ssh/
	rsync -azvP ~/.config/secrets desktop:~/.config/
	rsync -azvhP ~/.kube desktop:/home/aditya/
	rsync -azvhP ~/.aws desktop:/home/aditya/
