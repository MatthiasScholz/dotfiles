# modules/desktop/media/docs.nix

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.documents;
in {
  options.modules.desktop.media.documents = {
    enable = mkBoolOpt false;
    pdf.enable = mkBoolOpt false;
    ebook.enable = mkBoolOpt false;
    files.enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      (mkIf cfg.ebook.enable calibre)
      (mkIf cfg.pdf.enable   evince)
      (mkIf cfg.files.enable xfce.thunar)
      (mkIf cfg.files.enable xfce.thunar-volman)
      (mkIf cfg.files.enable xfce.thunar-archive-plugin)
      # zathura
    ];

    # TODO calibre/evince/zathura dotfiles
  };
}
