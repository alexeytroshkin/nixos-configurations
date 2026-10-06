{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  larksuite = pkgs.callPackage ../../modules/home/larksuite { };
  larksuite-cli = pkgs.callPackage ../../modules/home/larksuite-cli { };
in
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.zen-browser.homeModules.beta
    ../../modules/home/desktop/niri.nix
    ../../modules/home/shell.nix
    ../../modules/home/terminal.nix
    ../../modules/home/xdg
    ../../modules/home/vscode
    ../../modules/home/obsidian
    ../../modules/home/obsidian/vaults/expansion.nix
  ];

  programs.obsidian.vaults.spectrum.target = "./Workspaces/spectrum/docs";
  programs.ghostty.settings.theme = "dankcolors";

  # These optional custom files already exist on the laptop.
  programs.dank-material-shell.niri.includes.filesToInclude = [
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

  home.stateVersion = "25.11";
  home.username = "p47hf1nd3r";
  home.homeDirectory = "/home/p47hf1nd3r";
  home.packages = with pkgs; [
    adw-gtk3
    beekeeper-studio
    bitwarden-desktop
    (blender.override {
      config.cudaSupport = true;
      config.rocmSupport = false;
    })
    blockbench
    cursor-cli
    just
    larksuite
    larksuite-cli
    postman
    slack
    sops
    telegram-desktop
    unityhub
    yandex-music

    inputs.llm-agents.packages.${system}.but
    inputs.llm-agents.packages.${system}.chatgpt
    inputs.llm-agents.packages.${system}.gitbutler
    inputs.llm-agents.packages.${system}.gitnexus
    inputs.llm-agents.packages.${system}.zcode
    inputs.llm-agents.packages.${system}.codex
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

  programs.numbat = {
    enable = true;
  };

  programs.claude-code = {
    enable = true;
  };
}
