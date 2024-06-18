{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.development.gcc = {
      enable = lib.mkEnableOption "GCC compiler suite";
    };
  };

  config = lib.mkIf config.ggorg.development.gcc.enable {
    environment.systemPackages = with pkgs; [
      gcc
      gnumake
      cmake
    ];
  };
}
