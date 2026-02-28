{
  programs.helix = {
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
}
