switch:
	scripts/setup.sh
	darwin-rebuild --flake . switch

test:
	nix flake check --all-systems
