{ ... }:
{
  programs.bash = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    silent = true;
    nix-direnv = {
      enable = true;
    };
  };

}
