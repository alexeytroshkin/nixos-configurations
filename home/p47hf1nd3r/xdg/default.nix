{ pkgs, ... }:

{
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config = {
        niri = {
          "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
          default = [ "gnome" ];
        };
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
