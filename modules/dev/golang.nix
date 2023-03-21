# modules/dev/golang.nix ---

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let devCfg = config.modules.dev;
    cfg = devCfg.golang;
in {
  options.modules.dev.golang = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = [
        pkgs.go
        pkgs.gotools
        pkgs.gopls
        pkgs.go-outline
        pkgs.gocode
        pkgs.gopkgs
        pkgs.gocode-gomod
        pkgs.godef
        pkgs.golint
      ];
    })
  ];
}
