{
  pkgs,
  ...
}: {

  homebrew = {
      enable = true; 

      brews = [
        "helix"
      ];
      
      casks = pkgs.callPackage ./casks.nix {};
    };

  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
