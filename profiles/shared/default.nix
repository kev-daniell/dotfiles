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

    aerospace = {
      enable = true;
      settings = {
        "config-version" = 2;
        "after-startup-command" = [];
        "start-at-login" = false;
        "enable-normalization-flatten-containers" = true;
        "enable-normalization-opposite-orientation-for-nested-containers" = true;
        "accordion-padding" = 30;
        "default-root-container-layout" = "tiles";
        "default-root-container-orientation" = "auto";
        "on-focused-monitor-changed" = [ "move-mouse monitor-lazy-center" ];
        "automatically-unhide-macos-hidden-apps" = false;
        "persistent-workspaces" = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B" "C" "D" "E" "F" "G" "I" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" ];
        "on-mode-changed" = [];

        "key-mapping" = {
          preset = "qwerty";
        };

        gaps = {
          inner.horizontal = 5;
          inner.vertical = 5;
          outer = {
            left = 5;
            bottom = 5;
            top = 5;
            right = 5;
          };
        };

        mode = {
          main.binding = {
            "alt-slash" = "layout tiles horizontal vertical";
            "alt-comma" = "layout accordion horizontal vertical";
            "alt-h" = "focus left";
            "alt-j" = "focus down";
            "alt-k" = "focus up";
            "alt-l" = "focus right";
            "alt-shift-h" = "move left";
            "alt-shift-j" = "move down";
            "alt-shift-k" = "move up";
            "alt-shift-l" = "move right";
            "alt-minus" = "resize smart -50";
            "alt-equal" = "resize smart +50";
            "alt-1" = "workspace 1";
            "alt-2" = "workspace 2";
            "alt-3" = "workspace 3";
            "alt-4" = "workspace 4";
            "alt-5" = "workspace 5";
            "alt-6" = "workspace 6";
            "alt-7" = "workspace 7";
            "alt-8" = "workspace 8";
            "alt-9" = "workspace 9";
            "alt-a" = "workspace A";
            "alt-b" = "workspace B";
            "alt-c" = "workspace C";
            "alt-d" = "workspace D";
            "alt-e" = "workspace E";
            "alt-f" = "workspace F";
            "alt-g" = "workspace G";
            "alt-i" = "workspace I";
            "alt-m" = "workspace M";
            "alt-n" = "workspace N";
            "alt-o" = "workspace O";
            "alt-p" = "workspace P";
            "alt-q" = "workspace Q";
            "alt-r" = "workspace R";
            "alt-s" = "workspace S";
            "alt-t" = "workspace T";
            "alt-u" = "workspace U";
            "alt-v" = "workspace V";
            "alt-w" = "workspace W";
            "alt-x" = "workspace X";
            "alt-y" = "workspace Y";
            "alt-z" = "workspace Z";
            "alt-shift-1" = "move-node-to-workspace 1";
            "alt-shift-2" = "move-node-to-workspace 2";
            "alt-shift-3" = "move-node-to-workspace 3";
            "alt-shift-4" = "move-node-to-workspace 4";
            "alt-shift-5" = "move-node-to-workspace 5";
            "alt-shift-6" = "move-node-to-workspace 6";
            "alt-shift-7" = "move-node-to-workspace 7";
            "alt-shift-8" = "move-node-to-workspace 8";
            "alt-shift-9" = "move-node-to-workspace 9";
            "alt-shift-a" = "move-node-to-workspace A";
            "alt-shift-b" = "move-node-to-workspace B";
            "alt-shift-c" = "move-node-to-workspace C";
            "alt-shift-d" = "move-node-to-workspace D";
            "alt-shift-e" = "move-node-to-workspace E";
            "alt-shift-f" = "move-node-to-workspace F";
            "alt-shift-g" = "move-node-to-workspace G";
            "alt-shift-i" = "move-node-to-workspace I";
            "alt-shift-m" = "move-node-to-workspace M";
            "alt-shift-n" = "move-node-to-workspace N";
            "alt-shift-o" = "move-node-to-workspace O";
            "alt-shift-p" = "move-node-to-workspace P";
            "alt-shift-q" = "move-node-to-workspace Q";
            "alt-shift-r" = "move-node-to-workspace R";
            "alt-shift-s" = "move-node-to-workspace S";
            "alt-shift-t" = "move-node-to-workspace T";
            "alt-shift-u" = "move-node-to-workspace U";
            "alt-shift-v" = "move-node-to-workspace V";
            "alt-shift-w" = "move-node-to-workspace W";
            "alt-shift-x" = "move-node-to-workspace X";
            "alt-shift-y" = "move-node-to-workspace Y";
            "alt-shift-z" = "move-node-to-workspace Z";
            "alt-tab" = "workspace-back-and-forth";
            "alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";
            "alt-shift-semicolon" = "mode service";
          };
          service.binding = {
            esc = ["reload-config" "mode main"];
            r = ["flatten-workspace-tree" "mode main"];
            f = ["layout floating tiling" "mode main"];
            backspace = ["close-all-windows-but-current" "mode main"];
            "alt-shift-h" = ["join-with left" "mode main"];
            "alt-shift-j" = ["join-with down" "mode main"];
            "alt-shift-k" = ["join-with up" "mode main"];
            "alt-shift-l" = ["join-with right" "mode main"];
          };
        };
      };
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

        # TMUX PLUGINS:
        set -g @tpm_plugins '
            tmux-plugins/tpm \
            tmux-plugins/tmux-resurrect \
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
          cursorline = true;
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
            t = ":toggle-option lsp.display-inlay-hints";
            B = ":echo %sh{git blame -L %{cursor_line},+1 %{buffer_name}}";
          };
        };
      };
    };

    git = {
      enable = true;

      settings = {
        user = {
          name = "%GIT_NAME%";
          email = "%GIT_EMAIL%";
          signingkey = "%GPG_KEY_ID%";
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
