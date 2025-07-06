{
  pkgs,
  ...
}:

{
  imports = [
    ../../programs/default.nix
  ];

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
      helix
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
      rustup

      go
      ltex-ls
      pyright
      nats-server
      foundry
      lazygit
      (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
      terraform
      postgresql
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

        bind -r J resize-pane -D 5  # Shrink vertically
        bind -r K resize-pane -U 5  # Expand vertically
        bind -r H resize-pane -L 5  # Shrink horizontally
        bind -r L resize-pane -R 5  # Expand horizontally

        # annoying delay for escape key fix:
        set -sg escape-time 0
        
        # set base to 1 for windows and panes
        set -g base-index 1
        setw -g pane-base-index 1

        setw -g mode-keys vi

        # tmux resurrect
        set -g @plugin 'tmux-plugins/tmux-resurrect'
        
        # CATPPUCCIN CONFIG:
        set -g @tpm_plugins '
            tmux-plugins/tpm \
            tmux-plugins/tmux-online-status \
            tmux-plugins/tmux-battery \
        '

        
        # Configure Catppuccin
        set -g @catppuccin_flavor "macchiato"
        set -g @catppuccin_status_background "none"
        set -g @catppuccin_window_status_style "none"
        set -g @catppuccin_pane_status_enabled "off"
        set -g @catppuccin_pane_border_status "off"
        
        # Configure Online
        set -g @online_icon "ok"
        set -g @offline_icon "nok"
        
        # status left look and feel
        set -g status-left-length 100
        set -g status-left ""
        set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_bg},bold]  #S },#{#[bg=#{@thm_bg},fg=#{@thm_green}]  #S }}"
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_maroon}]  #{pane_current_command} "
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]#{?window_zoomed_flag,│,}"
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_yellow}]#{?window_zoomed_flag,  zoom ,}"
        
        # status right look and feel
        set -g status-right-length 100
        set -g status-right ""
        set -ga status-right "#{?#{e|>=:10,#{battery_percentage}},#{#[bg=#{@thm_red},fg=#{@thm_bg}]},#{#[bg=#{@thm_bg},fg=#{@thm_pink}]}} #{battery_icon} #{battery_percentage} "
        set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}, none]│"
        set -ga status-right "#[bg=#{@thm_bg}]#{?#{==:#{online_status},ok},#[fg=#{@thm_mauve}] 󰖩 on ,#[fg=#{@thm_red},bold]#[reverse] 󰖪 off }"
        set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}, none]│"
        set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_blue}] 󰭦 %Y-%m-%d 󰅐 %H:%M "

        # Configure Tmux
        set -g status-position top
        set -g status-style "bg=#{@thm_bg}"
        set -g status-justify "absolute-centre"
        
        # pane border look and feel
        setw -g pane-border-status top
        setw -g pane-border-format ""
        setw -g pane-active-border-style "bg=#{@thm_bg},fg=#{@thm_overlay_0}"
        setw -g pane-border-style "bg=#{@thm_bg},fg=#{@thm_surface_0}"
        setw -g pane-border-lines single
        
        # window look and feel
        set -wg automatic-rename on
        set -g automatic-rename-format "Window"
        
        set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
        set -g window-status-style "bg=#{@thm_bg},fg=#{@thm_rosewater}"
        set -g window-status-last-style "bg=#{@thm_bg},fg=#{@thm_peach}"
        set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
        set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
        set -gF window-status-separator "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}]│"
        
        set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
        set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"

        # bootstrap tpm
        if "test ! -d ~/.tmux/plugins/tpm" \
          "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"


        # Initialize TPM (this should be at the bottom of the file)
        run '~/.tmux/plugins/tpm/tpm'
      '';
    };

    helix = {
      enable = true;

      languages.language = [
        {
          name = "markdown";
          language-servers = [
            {
              name = "ltex-ls";
            }
          ];
        }
        {
          name = "python";
          language-servers = [
            {
              name = "pyright";
            }
          ];
        }
        {
          name = "typescript";
          language-servers = [
            {
              name = "typescript-language-server";
            }
          ];
        }
        {
          name = "javascript";
          language-servers = [
            {
              name = "typescript-language-server";
            }
          ];
        }
        {
          name = "rust";
          language-servers = [
            {
              name = "rust-analyzer";
            }
          ];
        }
      ];

      settings = {
        theme = "dark_plus";
        editor = {
          line-number = "relative";
          file-picker.hidden = false;
          bufferline = "multiple";
        };
        keys.normal = {
          # highlight lines upward
          X = ["extend_line_up" "extend_to_line_bounds"];
          C-h = "jump_view_left";
          C-j = "jump_view_down";
          C-k = "jump_view_up";
          C-l = "jump_view_right";
          space = {
            l = ":reload-all";
            u = ":reset-diff-change";
            o = ":reflow";
            T = ":tree-sitter-subtree";
          };
        };
      };
    };

    git = {
      enable = true;
      userName = "%GIT_NAME%";
      userEmail = "%GIT_EMAIL%";

      extraConfig = {
        init.defaultBranch = "main";
        
        core = {
          editor = "hx";
          excludesFile = "~/.gitignore_global";
        };

        pull.rebase = true;
        rebase.autoStash = true;
        merge.conflictstyle = "diff3";
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
