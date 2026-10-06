{ lib, ... }:
{
  programs.ghostty = {
    enable = true;

    settings = {
      # DMS generates dankcolors only after the first graphical login.
      theme = lib.mkDefault "Adwaita Dark";
      background-opacity = 0.875;
    };
  };

  programs.zellij = {
    enable = true;
  };

}
