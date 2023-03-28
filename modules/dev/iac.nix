# modules/dev/iac.nix ---

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let devCfg = config.modules.dev;
    cfg = devCfg.iac;
in {
  options.modules.dev.iac = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
    aws = rec {
      enable = mkBoolOpt false;
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = with pkgs; [
        terraform
        # TODO my.terramate
        tflint
        tfsec
        conftest
        open-policy-agent
        (mkIf (cfg.aws.enable)
          awscli2
          aws-vault
          # TODO my.clok-sm
        )
      ];
    })
  ];
}
