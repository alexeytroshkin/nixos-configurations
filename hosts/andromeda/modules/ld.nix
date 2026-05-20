{ pkgs, ... }:

{
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
}
