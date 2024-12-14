{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.development.python = {
      enable = lib.mkEnableOption "Python";
    };
  };

  config = lib.mkIf config.ggorg.development.python.enable {
    environment.systemPackages = with pkgs; [
      python312Full
      python312Packages.ipython
    ];
  };
}
