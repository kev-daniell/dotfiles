{
  description = "Kevin's personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    git-hooks,
    home-manager,
    nix-darwin,
    nixpkgs,
    ...
  }: let
    hostname = "Kevins-MacBook-Air";
    user = rec {
      username = "kevindaniel";
      homeDirectory = "/Users/${username}";
    };
    forEachSystem = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-darwin"
      "aarch64-linux"
    ];
    pre-commit-hooks = system:
      git-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          actionlint.enable = true;
          deadnix.enable = true;
          prettier.enable = true;
          statix.enable = true;
        };
      };
  in {
    darwinConfigurations."${hostname}" =  nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/darwin/configuration.nix
        ./hosts/shared/configuration.nix
        home-manager.darwinModules.home-manager
        {
          users.users.${user.username} = {
            home = user.homeDirectory;
            name = user.username;
          };
          home-manager = {
            extraSpecialArgs = { inherit user; };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user.username}.imports = [
              ./profiles/darwin       # Ensure this path exists
              ./profiles/shared
            ];
          };
        }
      ];
    };
   
    checks = forEachSystem (system: {
      system = pre-commit-hooks system;
    });

    devShells = forEachSystem (system: {
      default = nixpkgs.legacyPackages.${system}.mkShell {
        inherit (pre-commit-hooks system) shellHook;
      };
    });
  };
}
