{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Kevin Daniel";
        email = "kevindkevdan@gmail.com";
        signingkey = "9CCCB22C15A7302CDA83ED15337FAFBE9C57140E";
      };

      init.defaultBranch = "main";
      
      core = {
        editor = "hx";
        excludesFile = "~/.gitignore_global";
      };

      pull.rebase = true;
      rebase.autoStash = true;
      merge.conflictstyle = "diff3";
      commit.gpgSign = true;

      alias = {
        gone = "!f() { git fetch --all --prune; git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D; }; f";
        a = "add";
        b = "branch";
        bd = "branch -d";
        bdd = "branch -D";
        bc = "rev-parse --abbrev-ref HEAD";
        bu = "!git rev-parse --abbrev-ref --symbolic-full-name \"@{u}\"" ;
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
}
