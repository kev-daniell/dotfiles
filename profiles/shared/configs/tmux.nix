{ pkgs, ... }:

{
  programs.tmux = {
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

      # vim motions: witch tmux panes using Control + hjkl (No prefix)
      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R

      bind -r J resize-pane -D 5  # Shrink vertically
      bind -r K resize-pane -U 5  # Expand vertically
      bind -r H resize-pane -L 5  # Shrink horizontally
      bind -r L resize-pane -R 5  # Expand horizontally

      # new pane is in the same working dir as parent
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # force adding pane horizontally or vertically
      bind v split-window -fv -c "#{pane_current_path}"
      bind b split-window -fh -c "#{pane_current_path}"

      # annoying delay for escape key fix:
      set -sg escape-time 0
      
      # set base to 1 for windows and panes
      set -g base-index 1
      setw -g pane-base-index 1

      setw -g mode-keys vi

      # TMUX PLUGINS (TPM-managed; the nix-managed ones live in `plugins` above).
      # `@tpm_plugins` is deprecated in TPM, `@plugin` is the current syntax.
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-online-status'
      set -g @plugin 'tmux-plugins/tmux-battery'
      set -g @plugin 'accessd/tmux-agent-indicator'

      
      # Configure Catppuccin
      set -g @catppuccin_flavor "macchiato"
      set -g @catppuccin_status_background "none"
      set -g @catppuccin_window_status_style "none"
      set -g @catppuccin_pane_status_enabled "off"
      set -g @catppuccin_pane_border_status "off"
      
      # Configure Online
      set -g @online_icon "ok"
      set -g @offline_icon "nok"
      
      # Configure Agent Indicator
      # Only two visual channels are on: the window title in the centred window
      # list, and the status-left icon. Pane borders and pane backgrounds are
      # left alone so the muted catppuccin border styling below survives.
      set -g @agent-indicator-indicator-enabled "on"
      set -g @agent-indicator-border-enabled "off"
      set -g @agent-indicator-background-enabled "off"

      # Nerd Font icons - the upstream defaults are emoji, which are double-width
      # and break alignment against the glyphs used elsewhere in the status bar.
      set -g @agent-indicator-icons "claude=󰚩,codex=󰧑,opencode=,default=󰚩"

      # running: icon only, no window styling (empty bg+fg means "skip")
      set -g @agent-indicator-running-bg ""
      set -g @agent-indicator-running-border ""
      set -g @agent-indicator-running-window-title-bg ""
      set -g @agent-indicator-running-window-title-fg ""

      # needs-input: yellow, the same attention colour as the zoom flag
      set -g @agent-indicator-needs-input-bg ""
      set -g @agent-indicator-needs-input-border ""
      set -g @agent-indicator-needs-input-window-title-bg "#{@thm_yellow}"
      set -g @agent-indicator-needs-input-window-title-fg "#{@thm_bg}"

      # done: green. Upstream defaults to red, which collides with
      # window-status-activity-style and window-status-bell-style below.
      set -g @agent-indicator-done-bg ""
      set -g @agent-indicator-done-border ""
      set -g @agent-indicator-done-window-title-bg "#{@thm_green}"
      set -g @agent-indicator-done-window-title-fg "#{@thm_bg}"

      # hold the colour until the pane is actually focused, not when the hook fires
      set -g @agent-indicator-reset-on-focus "on"

      # the knight-rider animation hardcodes colour196/160/52 - off-palette
      set -g @agent-indicator-animation-enabled "off"

      # #{agent_limits} needs install.sh to wrap Claude's status-line command, and
      # #{agent_session_dots} needs bash 4+ (macOS ships bash 3.2). Both left out.
      set -g @agent-indicator-limits-enabled "off"

      # toasts off: tmux display-message renders *in* the status line, and with
      # status-position top that overlays the window tabs. The green/yellow window
      # title is the signal instead - same place you're already looking.
      set -g @agent-indicator-notification-enabled "off"

      
      # status left look and feel
      set -g status-left-length 100
      set -g status-left ""
      set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_bg},bold]  #S },#{#[bg=default,fg=#{@thm_green}]  #S }}"
      set -ga status-left "#[bg=default,fg=#{@thm_overlay_0},none]│"
      set -ga status-left "#[bg=default,fg=#{@thm_maroon}]  #{pane_current_command} "
      set -ga status-left "#[bg=default,fg=#{@thm_overlay_0},none]│"
      set -ga status-left "#[bg=default,fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "
      set -ga status-left "#[bg=default,fg=#{@thm_overlay_0},none]#{?window_zoomed_flag,│,}"
      set -ga status-left "#[bg=default,fg=#{@thm_yellow}]#{?window_zoomed_flag,  zoom ,}"
      # agent icon, rendered by tmux-agent-indicator. Kept last so it collapses to
      # nothing (no orphan separator) when no agent is running in this window.
      set -ga status-left "#[bg=default,fg=#{@thm_teal}]#{agent_indicator}"
      
      # status right look and feel
      set -g status-right-length 100
      set -g status-right ""
      set -ga status-right "#{?#{e|>=:10,#{battery_percentage}},#{#[bg=#{@thm_red},fg=#{@thm_bg}]},#{#[bg=default,fg=#{@thm_pink}]}} #{battery_icon} #{battery_percentage} "
      set -ga status-right "#[bg=default,fg=#{@thm_overlay_0}, none]│"
      set -ga status-right "#[bg=default]#{?#{==:#{online_status},ok},#[fg=#{@thm_mauve}] 󰖩 on ,#[fg=#{@thm_red},bold]#[reverse] 󰖪 off }"
      set -ga status-right "#[bg=default,fg=#{@thm_overlay_0}, none]│"
      set -ga status-right "#[bg=default,fg=#{@thm_blue}] 󰭦 %Y-%m-%d 󰅐 %H:%M "

      # Configure Tmux
      # #{agent_indicator} is backed by a #() shell call, so it only refreshes on
      # status-interval. tmux defaults to 15s, which feels dead.
      set -g status-interval 5
      set -g status-position top
      set -g status-style "bg=default"
      set -g status-justify "absolute-centre"
      
      # pane border look and feel
      setw -g pane-border-status top
      setw -g pane-border-format ""
      setw -g pane-active-border-style "bg=default,fg=#{@thm_overlay_0}"
      setw -g pane-border-style "bg=default,fg=#{@thm_surface_0}"
      setw -g pane-border-lines single
      
      # window look and feel
      set -wg automatic-rename on
      set -g automatic-rename-format "Window"
      
      set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
      set -g window-status-style "bg=default,fg=#{@thm_rosewater}"
      set -g window-status-last-style "bg=default,fg=#{@thm_peach}"
      set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
      set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
      set -gF window-status-separator "#[bg=default,fg=#{@thm_overlay_0}]│"
      
      set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
      set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"

      # bootstrap tpm
      if "test ! -d ~/.tmux/plugins/tpm" \
        "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"


      # Initialize TPM (this should be at the bottom of the file)
      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
