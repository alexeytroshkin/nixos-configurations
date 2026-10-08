{ lib, ... }:
{
  imports = [ ./niri-keybinds.nix ];

  programs.niri.settings = {
    outputs = (import ../monitor.nix).outputs;
    layout = {
      gaps = 8;
      border.width = 1;
      focus-ring.width = 1;
    };
    recent-windows.highlight.corner-radius = 8;
    blur = {
      passes = 5;
      offset = 5.0;
    };
    # Preserve the laptop's existing rounding, transparency and background blur.
    window-rules = lib.mkAfter [
      {
        geometry-corner-radius = {
          top-left = 8.0;
          top-right = 8.0;
          bottom-right = 8.0;
          bottom-left = 8.0;
        };
      }
      {
        matches = [ { app-id = "com.mitchellh.ghostty"; } ];
        background-effect.blur = true;
      }
      {
        matches = [
          { app-id = "code"; }
          { app-id = "^zen"; }
          { app-id = "org.keepassxc.KeePassXC"; }
          { app-id = "Throne"; }
        ];
        opacity = 0.875;
        background-effect.blur = true;
      }
    ];
  };

  # These fork-specific per-window options are not exposed by niri-flake's schema.
  # Keep the small extension immutable and generated from this Nix module.
  xdg.configFile."niri/andromeda-effects.kdl".text = ''
    window-rule {
      background-effect {
        noise 0.02
        saturation 2
      }
    }
  '';
  xdg.configFile.niri-config-dms.text = lib.mkAfter ''
    include "andromeda-effects.kdl"
  '';
}
