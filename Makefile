update:
	sudo nix-channel --update

host ?= x230
user ?= matthias
upgrade:
	sudo USER=$(user) nixos-rebuild switch --flake '.#$(host)' --option pure-eval no

apply:
	sudo hey rebuild
