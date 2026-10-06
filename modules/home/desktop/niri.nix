{ lib, ... }:
{
  # Hosts import the upstream DMS Home Manager modules alongside this one.
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
      layer-rules = [
        # В режиме обзора показываем обои вместо сплошного серого цвета
        {
          matches = [
            { namespace = "^quickshell$"; }
          ];
          place-within-backdrop = true;
        }
      ];
      window-rules = [
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
        filesToInclude = lib.mkDefault [
          "alttab"
          "binds"
          "colors"
          "cursor"
          "layout"
          "outputs"
          "windowrules"
          "wpblur"
        ];
      };
    };
  };

}
