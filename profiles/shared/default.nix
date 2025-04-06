{
  pkgs,
  ...
}: 


{
  home = {
    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };

    stateVersion = "22.05";

    packages = with pkgs; [
      vim
      gnupg

      # Node 
      nodejs
      nodePackages.npm # globally install npm
      yarn
      nodePackages.prettier
      nodePackages.nodemon
      nodePackages.typescript-language-server

      # Rust
      rustc
      cargo
      rustfmt

      python3
      go
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
