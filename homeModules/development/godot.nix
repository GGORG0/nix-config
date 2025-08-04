{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.development.godot = {
      enable = lib.mkEnableOption "Godot";
    };
  };

  config = lib.mkIf config.ggorg.development.godot.enable {
    home.packages = with pkgs; [
      godot
    ];
  };
}
