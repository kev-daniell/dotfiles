{
  pkgs,
  ...
}:

{
  imports = [
    ../../programs/default.nix
    ./configs/git.nix
    ./configs/tmux.nix
    ./configs/aerospace.nix
    ./configs/helix.nix
  ];

  home = {
    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };

    file = {
      ".gitignore_global" = {
        source = builtins.path {
          path = ../shared/configs/.gitignore_global;
        };
      };
    };

    stateVersion = "22.05";

    packages = with pkgs; [
      vim
      helix
      gnupg
      tmux
      gemini-cli

      # Node
      nodePackages.npm # globally install npm
      pnpm
      yarn
      bun
      nodePackages.prettier
      nodePackages.nodemon
      nodePackages.typescript-language-server

      # Rust
      rustup
      bacon

      go
      ltex-ls
      pyright
      (python3.withPackages (ps: with ps; [
        # don't need any other pkgs, just use virtual envs
        pip
      ]))
      nats-server
      natscli
      foundry
      lazygit
      (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
      terraform
      kubernetes-helm
      postgresql
      solana-cli
    ];
  };

  programs = {
    # Enable aider
    aider = {
      enable = true;
      editor = "hx";
      model = "gemini/gemini-2.5-flash-preview-05-20";
      autoCommit= false;
      geminiApiKey = "%GEMINI_KEY%";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
