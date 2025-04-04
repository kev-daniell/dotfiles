{
  pkgs,
  lib,
  ...
}: 

{
  home = {
    file = {
      ".zshrc" = {
        text = ''
          # Generated by Home Manager
          eval "$(/opt/homebrew/bin/brew shellenv)"

          source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
          # Import P10k config for command prompt
          [[ ! -f ./.p10k.zsh ]] || source ./.p10k.zsh
        '';
      };
      ".gitignore_global" = {
        source = builtins.path {
          path = ../shared/config/.gitignore_global;
        };
      };
      ".p10k.zsh" = {
        source = builtins.path {
          path = ./config/.p10k.zsh;
        };
      };
    };

    activation = {
      backupExistingFiles = lib.mkAfter ''
        # List of files to back up
        files_to_backup="
          .zshrc
          .zshenv
          .gitignore_global
        "

        # Loop through each file and back it up if it exists
        for file in $files_to_backup; do
          if [ -f "$HOME/$file" ]; then
            mv "$HOME/$file" "$HOME/$file.backup"
          fi
        done
      '';
    };

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };

    stateVersion = "22.05";

    packages = with pkgs; [
      vim
      gnupg
      nodejs
      nodePackages.npm # globally install npm
      nodePackages.prettier
      nodePackages.nodemon

      # TODO: add rust
      
      python3
      go
    ];
  };

  programs = {
    zsh = {
      enable = true; 
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
      shellAliases = {
        g = "git";
        h = "hx";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      userName = "Kevin Daniel"; # %CONFIG%
      userEmail = "kevindkevdan@gmail.com"; # %CONFIG%

      ignores = [ "*.swp" ];

      extraConfig = {
        init.defaultBranch = "main";
        core = {
          editor = "vim";
        };
        pull.rebase = true;
        rebase.autoStash = true;
        alias = {
          gone = "!f() { git fetch --all --prune; git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D; }; f";
          a = "add";
          aa = "add --all";
          ai = "add -i";
          b = "branch";
          ba = "branch -a";
          bd = "branch -d";
          bdd = "branch -D";
          br = "branch -r";
          bc = "rev-parse --abbrev-ref HEAD";
          bu = "!git rev-parse --abbrev-ref --symbolic-full-name \"@{u}\"";
          bs = "!git-branch-status";
          c = "commit";
          cm = "commit -m";
          cl = "clone";
          d = "diff";
          f = "fetch";
          fo = "fetch origin";
          l = "log --oneline";
          lg = "log --oneline --graph --decorate";
          m = "merge";
          ma = "merge --abort";
          mc = "merge --continue";
          ms = "merge --skip";
          ch = "checkout";
          chmst = "checkout master";
          chmain = "checkout main";
          chb = "checkout -b";
          ph = "push";
          phf = "push --force-with-lease";
          pl = "pull";
          pb = "pull --rebase";
          plo = "pull origin";
          pro = "pull --rebase origin";
          plom = "pull origin master";
          rb = "rebase";
          rba = "rebase --abort";
          rbc = "rebase --continue";
          rbi = "rebase --interactive";
          rbs = "rebase --skip";
          uncommit = "reset HEAD~1";
          s = "status";
          st = "stash"; 
          sc = "stash clear";
          sd = "stash drop";
          sl = "stash list";
          sp = "stash pop";
          ss = "stash save";
          ssh = "stash show";
          t = "tag";
          td = "tag -d";
        };
      };
    };

    home-manager.enable = true; # Let Home Manager install and manage itself.
  };
}