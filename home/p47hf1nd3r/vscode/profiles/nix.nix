#----------------------------------------------------------------
# Модуль для поддержки языка Nix.
# Предполагает, что в среде установлены пакеты nixd и nixfmt-rs
#----------------------------------------------------------------

{ pkgs, ... }:

{
  extensions = with pkgs.vscode-extensions; [
    jnoortheen.nix-ide
  ];
  userSettings = {
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";
    "nix.formatterPath" = "nixfmt";
    "nix.serverSettings" = {
      "nixd" = {
        "formatting" = {
          "command" = [ "nixfmt" ];
        };
      };
    };
    "[nix]" = {
      "editor.defaultFormatter" = "jnoortheen.nix-ide";
      "editor.formatOnSave" = true;
    };
  };
}
