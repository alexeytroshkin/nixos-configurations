{ config, pkgs, ... }:

{
  networking = {
    hostName = "corvus";
    networkmanager = {
      enable = true;
      ensureProfiles = {
        profiles = {
          "GL-MT6000-9b8-5G" = {
            connection = {
              id = "GL-MT6000-9b8-5G";
              type = "wifi";
              interface-name = "wlan0";
            };
            wifi = {
              mode = "infrastructure";
              ssid = "GL-MT6000-9b8-5G";
            };
            wifi-security = {
              auth-alg = "open";
              key-mgmt = "wpa-psk";
              psk = "$GL-MT6000-9b8-5G";
            };
            ipv4.method = "auto";
            ipv6.method = "auto";
          };
        };
      };
    };
    firewall = {
      allowedTCPPorts = [
        # beszel
        8090
        # nginx
        80
        443
      ];
    };
  };

  systemd.services.NetworkManager = {
    serviceConfig.EnvironmentFile = config.sops.templates."networkmanager_env".path;
  };
}
