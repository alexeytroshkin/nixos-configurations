{ inputs, pkgs, ... }:

{
  nixpkgs = {
    overlays = [
      inputs.niri.overlays.niri
    ];
  };

  # Используем polkit агента от DMS вместо агента из niri-flake
  systemd = {
    user = {
      services = {
        niri-flake-polkit.enable = false;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      # Костыли для работы X11 приложений
      xwayland
      xwayland-satellite
      # Требуется для gnome портала
      nautilus
    ];
    # ? (кажется нужно было для dms-shell)
    pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland"; # Принудительный запуск приложений на базе Qt в режиме wayland
      # NIXOS_OZONE_WL = "1"; # Принудительный запуск приложений на базе Chromium и Electron в режиме wayland вместо xwayland
      # GDK_BACKEND = "wayland,x11"; # Принудительный запуск приложений на базе Gtk в режиме wayland
    };
  };

  services = {
    # Включаем DMS greeter с частичным дублированием настроек композитора т.к. сам почему то не подхватывает.
    displayManager.dms-greeter = {
      enable = true;
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
    # GVfs необходимо для nautilus
    gvfs = {
      enable = true;
    };
  };

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    dms-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      #----------------------------------------------------------------
      # DMS shell запускает Niri благодаря enableSpawn в home manager'e.
      # Эти настройки конфликтуют, поэтому здесь ставим false
      #----------------------------------------------------------------
      systemd.enable = false;
    };
  };
}
