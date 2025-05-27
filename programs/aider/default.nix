{
  pkgs,
  ...
}:
let
  aider-python = pkgs.python312.withPackages (ps: with ps; [
    aider-chat
    google-generativeai
  ]);
in
{
  home.packages = with pkgs; [
    aider-python
  ];
}
