{
  pkgs,
  ...
}: 


{
  home = {
    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };

    file = {
      ".gitignore_global" = {
        source = builtins.path {
          path = ../shared/config/.gitignore_global;
        };
      };
    };

    stateVersion = "22.05";

    packages = with pkgs; [
      vim
      gnupg
      tmux
      fzf

      # Node 
      nodejs
      nodePackages.npm # globally install npm
      pnpm
      yarn
      bun
      nodePackages.prettier
      nodePackages.nodemon
      nodePackages.typescript-language-server

      # Rust
      rustc
      cargo
      rustfmt
      clippy

      python3
      go
      nats-server
      foundry
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    tmux = {
      enable = true;
      terminal = "tmux-256color";

      plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      yank

      catppuccin
    ];
      # Replaces ~/.config/tmux/tmux.conf
      extraConfig = ''
        bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded."

        setw -g mouse on

        # vim motions
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        set -g @catppuccin_flavour 'mocha'
      '';
  };

    git = {
      enable = true;
      userName = "%GIT_NAME%";
      userEmail = "%GIT_EMAIL%";

      extraConfig = {
        init.defaultBranch = "main";
        
        core = {
          editor = "vim";
          excludesFile = "~/.gitignore_global";
        };

        pull.rebase = true;
        rebase.autoStash = true;
        user.signingkey = "%GPG_KEY_ID%";
        commit.gpgSign = true;

        alias = {
          gone = "!f() { git fetch --all --prune; git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D; }; f";
          a = "add";
          b = "branch";
          bd = "branch -d";
          bdd = "branch -D";
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
          chmn = "checkout main";
          chb = "checkout -b";
          p = "push";
          pf = "push --force-with-lease";
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
        };
      };
    };
  };
}
