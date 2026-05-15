{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
    inputs.sops-nix.nixosModules.sops
    ./hardware-configuration.nix
    ./modules/networking.nix
    ./modules/services.nix
    ./../../modules/sops
  ];

  boot = {
    loader = {
      # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
      grub.enable = false;
      # Enables the generation of /boot/extlinux/extlinux.conf
      generic-extlinux-compatible.enable = true;
    };
  };

  nix = {
    settings = {
      trusted-users = [
        "p47hf1nd3r"
      ];
    };
  };

  time.timeZone = "Europe/Moscow";

  users = {
    mutableUsers = false;
    users = {
      p47hf1nd3r = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.p47hf1nd3r_pswd.path;
        extraGroups = [ 
          "wheel" 
          "networkmanager" 
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKW0ooE2hLuk64i95rZyfIynDzL7hfA2PxPb5UQ3j82u p47hf1nd3r"
        ];
        packages = with pkgs; [];
      };
    };
  };

  environment.systemPackages = with pkgs; [];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}