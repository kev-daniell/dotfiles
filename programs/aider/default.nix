{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.programs.aider;
in {
  options.programs.aider = {
    enable = mkEnableOption "Aider AI coding assistant";

    autoCommit= mkOption {
      type = types.bool;
      default = true;
      description = "Whether aider should automatically commit changes.";
    };

    editor = mkOption {
      type = types.str;
      default = "vim";
      description = "The editor aider should use.";
    };

    model = mkOption {
      type = types.str;
      default = "gpt-4o";
      description = "The AI model aider should use.";
    };

    geminiApiKey = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "API key for Gemini models.";
    };
  };

  config = mkIf cfg.enable {
    # Generate aider config file
    home.file.".aider.conf.yml".text = ''
      auto-commits: ${
        if cfg.autoCommit
        then "true" 
        else "false"  
      }
      editor: ${cfg.editor}
      model: ${cfg.model}
      ${optionalString (cfg.geminiApiKey != null) "api-key:\n  - gemini=${cfg.geminiApiKey}"}
    '';

    home.packages = [
      pkgs.aider-chat
    ];
  };
}
