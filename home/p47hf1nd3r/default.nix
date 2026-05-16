{ pkgs, inputs, ... }:
let
  larksuite = pkgs.callPackage ./larksuite { };
  larksuite-cli = pkgs.callPackage ./larksuite-cli { };
in
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.zen-browser.homeModules.beta
    ./xdg
    ./vscode
  ];

  home.stateVersion = "25.11";
  home.username = "p47hf1nd3r";
  home.homeDirectory = "/home/p47hf1nd3r";
  home.packages = with pkgs; [
    just
    yandex-music
    telegram-desktop
    slack
    larksuite
    larksuite-cli
  ];

  home.file = {
    ".ssh/alexeytroshkin.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILOP+oarT7n0iJGxr2NIRfE7dM+6POgD65ysJJF9hz/S alexeytroshkin@github.com
    '';
    ".ssh/alexey-troshkin-xpress.pub".text = ''
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCuJnfhaapxPn863SwLTpW0+MRbuOyzw0msWZw03lWDxKyxRa9tfSVDoSkZAEeR1FKOrMB+yTIzjL+o65B0FwaB385PaTnss4gZLm1Na1hNGPyXSsOwaojJer/L6Nuhg8SRTEMm0N6FcSAwEEoCkDX9FanS1gw3dgzDyZCC+EwjElzn7WBt1YHtASu+CX4YKOJaXwgV87QGHSSCseV8sdaatromMMnl+Dsol7juJGCNsckhAsciX+Cm152+mthV11hjI/UV01fOIEaPlcsBnqVYTYS8uUw5TQGUVm8iKhqfUcmOCVyrIgI5/blU6FT/UZUKVTFYcXT+++ij9KFFeqVYT+HpBuzt5PmMJpJYhik7HLsQqDV1XRyesZ6h7OkMCHXmgBPQeQB7TBFjN3sRXjhLJK9Gxu6OK9AStksBI2mHR78aIz9WPzEFuRN8qLQVkvNfV4xpMFXufqYIf1OnCCoVpt2AgETwR/Vzqw6FQFROYCgErywksZ1SU8D3lxQtYJsFyZesBKrC6CNtFRt5uXJCys8m2fBwXVd3q62I51i1wF5ppT70GdknVunywnrxflXd0ROlo95yRezBTte3oY2jpx53Fc/Z9NJFHe+U+4Bex7HV/8LkO+hifOu8K+UcXUcmqsv5g5HfM2aor+lUKlO99zpd4lRt29IiUEAHeSWrTw== p47hf1nd3r@DESKTOP-BGSGPVV
    '';
    ".ssh/corvus-p47hf1nd3r.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKW0ooE2hLuk64i95rZyfIynDzL7hfA2PxPb5UQ3j82u p47hf1nd3r
    '';
    ".ssh/sops.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG3kpY7Ob84ITuv0wz6p7ZSWUfGBgJXa6xQIcH1Pcne+ sops
    '';
    ".config/git/alexey-troshkin-xpress".text = ''
      [user]
        email = alexey.troshkin@xpress.com.ph
        name = Alexey Troshkin
        signingkey = C9BFFBBA382552AE
      [commit]
        gpgsign = true
      [core]
        sshCommand = "ssh -o IdentitiesOnly=yes -i ~/.ssh/alexey-troshkin-xpress.pub"
    '';
  };

  programs.git = {
    enable = true;

    settings = {
      core = {
        editor = "nvim";
        sshCommand = "ssh -o IdentitiesOnly=yes -i ~/.ssh/alexeytroshkin.pub";
      };
      user = {
        email = "alextroshkin@outlook.com";
        name = "Alexey Troshkin";
      };
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com";
        };
      };
      includeIf = {
        "gitdir/i:~/Workspaces/alexey-troshkin-xpress/" = {
          path = "~/.config/git/alexey-troshkin-xpress";
        };
      };
    };
  };

  programs.niri = {
    settings = {
      prefer-no-csd = true;
      hotkey-overlay = {
        skip-at-startup = true;
      };
      input = {
        keyboard = {
          xkb = {
            layout = "us, ru";
            options = "grp:alt_shift_toggle";
          };
        };
      };
      layout = {
        background-color = "transparent";
        preset-column-widths = [
          { proportion = 1. / 4.; }
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
          { proportion = 3. / 4.; }
        ];
      };
      overview = {
        # В режиме обзора убираем тень вокруг рабочих пространств
        workspace-shadow = {
          enable = false;
        };
      };
      layer-rules = [
        # В режиме обзора показываем обои вместо сплошного серого цвета
        {
          matches = [
            { namespace = "^quickshell$"; }
          ];
          place-within-backdrop = true;
        }
      ];
      window-rules = [
        # Открывать окна относящиеся к DMS как "плавающие" по умолчанию
        {
          matches = [
            { app-id = "org.quickshell$"; }
          ];
          open-floating = true;
        }
      ];
    };
  };

  programs.dank-material-shell = {
    enable = true;

    niri = {
      enableSpawn = true;
      includes = {
        enable = true;
        override = true;
        originalFileName = "hm";
        filesToInclude = [
          "alttab"
          "binds"
          "colors"
          "cursor"
          "layout"
          "outputs"
          "windowrules"
          "wpblur"
          "../blur"
          "../windowrules"
        ];
      };
    };
  };

  programs.ghostty = {
    enable = true;

    settings = {
      theme = "dankcolors";
      background-opacity = 0.875;
    };
  };

  programs.zellij = {
    enable = true;
  };

  programs.superfile = {
    enable = true;

    settings = {
      transparent_background = true;
    };
  };

  programs.keepassxc = {
    enable = true;

    settings = {
      SSHAgent = {
        Enabled = true;
        UseOpenSSH = true;
      };
    };
  };

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };
}
