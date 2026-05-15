{ config, pkgs, ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "alextroshkin@outlook.com";
  };

  services = {   
    openssh.enable = true;
    
    beszel = {
      hub = {
        enable = true;
        host = "0.0.0.0";
        port = 8090;
      };
      agent = {
        enable = true;
        environment = {
          KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHOaZwkyoUgXRr+UZg80fODDRuFBdhM3VpXGhhbWtIg+";
        };
      };
    };

    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://vaultwarden.p47hf1nd3r.xyz";
        SIGNUPS_ALLOWED = true;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
      };
    };

    # forgejo = {
    #   enable = true;
    #   user = "p47hf1nd3r";
    # };

    nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."vaultwarden.p47hf1nd3r.xyz" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8222";
        };
      };
    };
  };
}