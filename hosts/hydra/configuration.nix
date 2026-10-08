{ inputs, pkgs, ... }:
{
  imports = [
    inputs.niri.nixosModules.niri
    inputs.dank-greeter.nixosModules.default
    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/windows-disk.nix
    ../../modules/nixos/desktop/niri.nix
    ../../modules/nixos/virtualisation/podman.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 10;
    efi.efiSysMountPoint = "/boot";
    # Keep the existing firmware entries, including Windows Boot Manager.
    efi.canTouchEfiVariables = false;
  };

  networking.hostName = "hydra";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";
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

  users.users.p47hf1nd3r = {
    isNormalUser = true;
    description = "p47hf1nd3r";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEPcEQfDE58oAK2pgyEZ4Ib83qis8QsOyZL/7KxsQhP p47hf1nd3r@andromeda-to-hydra"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      # Keep the existing login available during bootstrap.
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  services.udisks2.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Required for copying locally built closures over SSH.
    trusted-users = [
      "root"
      "p47hf1nd3r"
    ];
  };
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    neovim
    nixd
    nixfmt-rs
    pciutils
    podman-compose
  ];
  programs.gnupg.agent.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu
      libsecret
      openssl
      stdenv.cc.cc.lib
      zlib
    ];
  };

  # The installed system was initialized with NixOS 26.05.
  system.stateVersion = "26.05";
}
