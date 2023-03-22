{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.gnome;
    configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.gnome = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services = {
      picom.enable = true;
      redshift.enable = true;
      xserver = {
        # Enable the X11 windowing system.
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };

    # link recursively so other modules can link files in their folders
    home.configFile = {
      "gnome" = {
        source = "${configDir}/gnome";
        recursive = true;
      };
    };
  };
}
