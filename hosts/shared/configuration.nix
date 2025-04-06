{
  pkgs,
  ...
}: {
  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };

  nix = {
    enable = false;

    extraOptions = ''
      min-free = ${toString (2 * 1024 * 1024 * 1024)}
      max-free = ${toString (10 * 1024 * 1024 * 1024)}
    '';

    # Required to use flakes, which are an experimental module
    package = pkgs.nixVersions.nix_2_24;

    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "@admin"
      ];
    };
  };

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;
  };
}
