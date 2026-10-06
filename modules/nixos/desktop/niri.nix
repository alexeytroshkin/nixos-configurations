{ inputs, pkgs, ... }:

{
  # Hosts import the upstream Niri and dank-greeter modules alongside this one.
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
    dms-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/p47hf1nd3r";
    };
  };
}
