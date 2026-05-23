# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-legion-16arh7h-hybrid
    inputs.niri.nixosModules.niri
    ./hardware-configuration.nix
    ./modules/ld.nix
    ./modules/gpg.nix
    ./modules/virtualisation.nix
    ./modules/xwayland.nix
    ./modules/vpn.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "andromeda"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.p47hf1nd3r = {
    isNormalUser = true;
    description = "p47hf1nd3r";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Configure nix
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt-rs
    neovim
    git
    nautilus
  ];

  # Niri related

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  # use dms polkit agent instead of niri-flake agent
  systemd.user.services.niri-flake-polkit.enable = false;

  # Dankmaterialshell

  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    systemd.enable = false; # use enableSpawn in home-manager
  };

  services.displayManager.dms-greeter = {
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

  #----------------------------------------------------------------

  services.logind = {
    settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitchExternalPower = "ignore";
    };
  };

  #----------------------------------------------------------------

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland"; # Принудительный запуск приложений на базе Qt в режиме wayland
    # NIXOS_OZONE_WL = "1"; # Принудительный запуск приложений на базе Chromium и Electron в режиме wayland вместо xwayland
    # GDK_BACKEND = "wayland,x11"; # Принудительный запуск приложений на базе Gtk в режиме wayland
  };

  #----------------------------------------------------------------
  # Идентификаторы в nixos-hardware не совпадают с фактическими
  # поскольку конфиг взят от другой модели
  # https://github.com/NixOS/nixos-hardware/blob/master/lenovo/legion/16arh7h/hybrid/default.nix
  #
  # Требуется заменить amdgpuBusId на 6:0:0. Без этого UI сильно тормозит
  #----------------------------------------------------------------

  hardware.nvidia.prime = {
    amdgpuBusId = "PCI:6:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
