update:
  sudo nix-channel --update

host ?= x230
upgrade:
  sudo nixos-rebuild switch --flake '.#$(host)' --option pure-eval no
 
apply:
  sudo hey rebuild
