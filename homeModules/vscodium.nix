{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.vscodium.enable = lib.mkEnableOption "Git" // {default = true;};
  };

  config = {
    programs.vscode = {
      inherit (config.ggorg.vscodium) enable;
      package = pkgs.vscodium;
    };
  };
}
