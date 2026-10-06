{ inputs, pkgs, ... }:
{
  services = {
    # Включаем DMS greeter с частичным дублированием настроек композитора т.к. сам почему то не подхватывает.
    displayManager.dms-greeter = {
      enable = false;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      compositor = {
        name = "niri";
        customConfig = ''
          hotkey-overlay { 
            skip-at-startup; 
          }
          output "HDMI-A-1" {
            mode "7680x2160@119.997"
            scale 1.5
            position x=0 y=0
            layout {
              always-center-single-column
            }
          }
          output "eDP-1" {
            mode "2560x1600@240.000"
            scale 1.5
            position x=0 y=0
            layout {
              always-center-single-column
            }
          }
        '';
      };
      configHome = "/home/p47hf1nd3r";
    };
  };
}
