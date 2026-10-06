{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    ../../modules/home/desktop/niri.nix
    ../../modules/home/desktop/niri-keybinds.nix
    ../../modules/home/xdg
    ../../modules/home/shell.nix
    ../../modules/home/terminal.nix
    ../../modules/home/obsidian
  ];

  home.username = "p47hf1nd3r";
  home.homeDirectory = "/home/p47hf1nd3r";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    adw-gtk3
    just
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Alexey Troshkin";
      user.email = "alextroshkin@outlook.com";
      core.editor = "nvim";
    };
  };
  programs.firefox.enable = true;

  home.pointerCursor = {
    enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  gtk.enable = true;
  programs.niri.settings.cursor = {
    theme = config.home.pointerCursor.name;
    size = config.home.pointerCursor.size;
  };

  programs.niri.settings.outputs = (import ./monitor.nix).outputs;
  # Keep host monitor settings authoritative instead of DMS-generated outputs.
  programs.dank-material-shell.niri.includes.filesToInclude = [
    "alttab"
    "binds"
    "colors"
    "cursor"
    "layout"
    "windowrules"
    "wpblur"
  ];

  # Vaults are selected here when hydra's working directories are ready.
}
