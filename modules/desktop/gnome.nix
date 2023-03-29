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

    # SEE: https://nixos.wiki/wiki/GNOME
    environment.systemPackages = with pkgs; [
      gnomeExtensions.appindicator
    ];

    services.udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];

    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      ]) ++ (with pkgs.gnome; [
        cheese # webcam tool
        gnome-music
        gnome-terminal
        gedit # text editor
        epiphany # web browser
        geary # email reader
        #evince # document viewer
        #gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
      ]);

    # link recursively so other modules can link files in their folders
    #home.configFile = {
    #  "gnome" = {
    #    source = "${configDir}/gnome";
    #    recursive = true;
    #  };
    #};
  };
}
