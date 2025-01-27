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
      package = pkgs.vscodium.override {
        commandLineArgs = [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform-hint=auto"
          "--ozone-platform=wayland"
        ];
      };
    };

    home.packages = lib.mkIf config.ggorg.vscodium.enable [
      pkgs.clang-tools
    ];
  };
}
