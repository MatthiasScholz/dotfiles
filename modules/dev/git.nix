# modules/dev/cc.nix --- C & C++
#
# I love C. I tolerate C++. I adore C with a few choice C++ features tacked on.
# Liking C/C++ seems to be an unpopular opinion. It's my guilty secret, so don't
# tell anyone pls.

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let devCfg = config.modules.dev;
    cfg = devCfg.git;
in {
  options.modules.dev.git = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      # TODO make connection to $USER env variable and make it configurable
      userName  = "Matthias Scholz";
      userEmail = "matthias.scholz@gmail.com";
    };
  };
}
