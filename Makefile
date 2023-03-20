update:
	sudo nix-channel --update

host ?= x230
user ?= matthias
upgrade:
	sudo USER=$(user) nixos-rebuild switch --flake '.#$(host)' --option pure-eval no
  sudo passwd $(user)

wifi_ssid := UntermDach
wifi_pw := unset
wifi:
  sudo nmcli device wifi connect $(wifi_ssid) password $(wifi_pw)

apply:
	sudo hey rebuild
