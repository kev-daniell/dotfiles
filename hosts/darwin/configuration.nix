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

  system.keyboard = {
    enableKeyMapping = true;   
    remapCapsLockToEscape = true;
  };

  system.defaults = {
    # Tap to click
    trackpad.Clicking = true;

    # Tracking speed
    NSGlobalDomain."com.apple.trackpad.scaling" = 2.0;

    dock = {
      # Dock
      autohide = true;

      # Hot corners
      wvous-bl-corner = 13; # lock screen
      wvous-br-corner = 11; # launchpad
      wvous-tr-corner = 2;  # mission control 

      # Fully declarative dock
      persistent-apps = [
        { app = "/System/Applications/Launchpad.app/"; }
        { app = "/Applications/Google Chrome.app/"; }
        { app = "/Applications/Firefox.app/"; }
        { app = "/Applications/Safari.app/"; }
        { app = "/System/Applications/Messages.app/"; }
        { app = "/Applications/Telegram.app/"; }
        { app = "/Applications/Microsoft Outlook.app/"; }

        { app = "/Applications/Visual Studio Code.app/"; }
        { app = "/Applications/Cursor.app/"; }
        { app = "/Applications/Postman.app/"; }
        { app = "/Applications/iTerm.app/"; }
        { app = "/Applications/Discord.app/"; }
        { app = "/Applications/Slack.app/"; }
        { app = "/Applications/Spotify.app/"; }

        { app = "/System/Applications/Maps.app/"; }
        { app = "/System/Applications/Photos.app/"; }
        { app = "/System/Applications/Calendar.app/"; }
        { app = "/System/Applications/Notes.app/"; }
        { app = "/System/Applications/Facetime.app/"; }
        { app = "/Applications/Microsoft Word.app/"; }
        { app = "/System/Applications/Music.app/"; }
        { app = "/System/Applications/News.app/"; }
        { app = "/System/Applications/Photo Booth.app/"; }
        { app = "/System/Applications/TV.app/"; }
        { app = "/System/Applications/News.app/"; }

        { app = "/System/Applications/App Store.app/"; }
        { app = "/System/Applications/System Settings.app/"; }
        { app = "/System/Applications/Utilities/Activity Monitor.app/"; }
      ];
    };
  };
  
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
