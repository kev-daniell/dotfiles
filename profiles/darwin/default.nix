{
  pkgs,
  ...
}: 

{
  home.file.".p10k.zsh" = {
    source = builtins.path { path = ./config/.p10k.zsh; };
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
      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        tmux source-file ~/.config/tmux/tmux.conf
      '';
      shellAliases = {
        g = "git";
        h = "hx";
        lg = "lazygit";
        ai = "aider";
      };
    };

    home-manager.enable = true; # Let Home Manager install and manage itself.
  };
}
