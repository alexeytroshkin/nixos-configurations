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
    ./modules/gui
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Добавляем поддержку файловых систем для монтируемых устройств
    supportedFilesystems = [
      "ntfs"
      "vfat"
      "exfat"
    ];
  };

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

  environment = {
    systemPackages = with pkgs; [
      nixd
      nixfmt-rs
      neovim
      git
    ];
  };

  hardware = {
    #----------------------------------------------------------------
    # Идентификаторы в nixos-hardware не совпадают с фактическими
    # поскольку конфиг взят от другой модели
    # https://github.com/NixOS/nixos-hardware/blob/master/lenovo/legion/16arh7h/hybrid/default.nix
    #
    # Требуется заменить amdgpuBusId на 6:0:0. Без этого UI сильно тормозит
    #----------------------------------------------------------------
    nvidia.prime = {
      amdgpuBusId = "PCI:6:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    #----------------------------------------------------------------
    # Почему то в nixos-hardware не учитывается bluetooth.
    # Включаем сами.
    #----------------------------------------------------------------
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  };

  services = {
    # Отключаем какие либо действия при закрытии крышки лэптопа
    logind = {
      settings.Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchDocked = "ignore";
        HandleLidSwitchExternalPower = "ignore";
      };
    };
    udisks2 = {
      enable = true;
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  programs = {
    gnupg = {
      agent = {
        enable = true;
      };
    };
    #----------------------------------------------------------------
    # Включено для работы aspire. Без nix-ld была ошибка с бинарником
    # DCP - проще было обойтись так
    #----------------------------------------------------------------
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        icu
        libsecret
        openssl
        stdenv.cc.cc.lib
        zlib
      ];
    };
    amnezia-vpn = {
      enable = true;
    };
    throne = {
      enable = true;
      tunMode = {
        enable = true;
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
