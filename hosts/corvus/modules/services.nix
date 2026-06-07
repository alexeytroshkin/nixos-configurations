{ ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "alextroshkin@outlook.com";
  };

  # Бан за перебор паролей на странице входа в vaultwarden
  environment.etc."fail2ban/filter.d/vaultwarden.conf".text = ''
    [Definition]
    failregex = ^.*\[vaultwarden::api::identity\]\[ERROR\] Username or password is incorrect\..*IP: <ADDR>\.
    ignoreregex =
  '';

  services = {
    openssh = {
      enable = true;
    };

    fail2ban = {
      enable = true;
      maxretry = 5;
      bantime = "1h";
      jails = {
        # Бан за перебор паролей на странице входа в vaultwarden
        vaultwarden = {
          settings = {
            enabled = true;
            port = "http,https";
            filter = "vaultwarden";
            backend = "systemd";
            journalmatch = "_SYSTEMD_UNIT=vaultwarden.service";
          };
        };
        nginx-botsearch = {
          settings = {
            enabled = true;
            port = "http,https";
            filter = "nginx-botsearch";
            backend = "systemd";
            journalmatch = "_SYSTEMD_UNIT=nginx.service";
          };
        };
      };
    };

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
        SIGNUPS_ALLOWED = false;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
      };
      backupDir = "/mnt/backup/vaultwarden";
    };

    nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      # Пишем логи в systemd journal что бы fail2ban мог с ними работать
      commonHttpConfig = ''
        access_log syslog:server=unix:/dev/log;
        error_log syslog:server=unix:/dev/log error;
      '';

      virtualHosts."vaultwarden.p47hf1nd3r.xyz" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8222";
          # Добавлено для корректной работы пуш-уведомлений в приложениях Bitwarden/Vaultwarden
          proxyWebsockets = true;
        };
      };
    };
  };
}
