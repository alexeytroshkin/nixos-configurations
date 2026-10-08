{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Nix owns persistent compositor settings; DMS owns the dynamic palette.
  programs.niri = {
    settings = {
      prefer-no-csd = true;
      hotkey-overlay = {
        skip-at-startup = true;
      };
      input = {
        keyboard = {
          xkb = {
            layout = "us, ru";
            options = "grp:alt_shift_toggle";
          };
        };
      };
      layout = {
        background-color = "transparent";
        gaps = lib.mkDefault 4;
        border.width = lib.mkDefault 2;
        focus-ring.width = lib.mkDefault 2;
        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
        ];
      };
      overview = {
        # В режиме обзора убираем тень вокруг рабочих пространств
        workspace-shadow = {
          enable = false;
        };
      };
      cursor = {
        theme = lib.mkDefault config.home.pointerCursor.name;
        size = lib.mkDefault config.home.pointerCursor.size;
      };
      recent-windows.highlight.corner-radius = lib.mkDefault 12;
      layer-rules = [
        {
          matches = [ { namespace = "dms:blurwallpaper"; } ];
          place-within-backdrop = true;
        }
        # В режиме обзора показываем обои вместо сплошного серого цвета
        {
          matches = [
            { namespace = "^quickshell$"; }
          ];
          place-within-backdrop = true;
        }
      ];
      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-right = 12.0;
            bottom-left = 12.0;
          };
          clip-to-geometry = true;
          tiled-state = true;
          draw-border-with-background = false;
        }
        {
          matches = [ { app-id = "^com.danklinux.dms$"; } ];
          open-floating = true;
        }
        # Открывать окна относящиеся к DMS как "плавающие" по умолчанию
        {
          matches = [
            { app-id = "org.quickshell$"; }
          ];
          open-floating = true;
        }
      ];
    };
  };

  programs.dank-material-shell = {
    enable = true;

    niri = {
      enableSpawn = true;
      includes = {
        enable = true;
        override = true;
        originalFileName = "hm";
        filesToInclude = [ "colors" ];
      };
    };
  };

  home.pointerCursor = {
    enable = true;
    name = lib.mkDefault "Adwaita";
    package = lib.mkDefault pkgs.adwaita-icon-theme;
    size = lib.mkDefault 24;
    gtk.enable = true;
    x11.enable = true;
  };

}
