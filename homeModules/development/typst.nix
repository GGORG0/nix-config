{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.development.typst = {
      enable = lib.mkEnableOption "Typst";
    };
  };

  config = lib.mkIf config.ggorg.development.typst.enable {
    home.packages = with pkgs; [
      typst
      typstyle
      typst-live
    ];
  };
}
