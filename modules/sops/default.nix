{ config, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    gnupg.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    secrets = {
      wifi_psk = { };
      p47hf1nd3r_pswd = {
        neededForUsers = true;
      };
    };
    templates = {
      "networkmanager_env" = {
        content = ''
          GL-MT6000-9b8-5G=${config.sops.placeholder.wifi_psk}
        '';
        owner = "root";
      };
    };
  };
}
