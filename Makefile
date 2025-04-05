build:
	darwin-rebuild --flake . switch

.PHONY: test

test:
	nix flake check --all-systems
