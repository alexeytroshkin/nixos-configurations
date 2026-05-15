{ pkgs, lib, ... }:
let
  common = import ./profiles/common.nix { inherit pkgs; };
  dotnet = import ./profiles/dotnet.nix { inherit pkgs; };
  nix = import ./profiles/nix.nix { inherit pkgs; };
in
{
  programs.vscode = {
    enable = true;
    profiles = {
      "default" = lib.mkMerge [
        common
        nix
      ];

      "Work" = lib.mkMerge [
        common
        dotnet
      ];
    };
  };
}
