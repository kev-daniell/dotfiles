switch:
	scripts/setup.sh
	sudo -H darwin-rebuild --flake . switch

test:
	nix flake check --all-systems
