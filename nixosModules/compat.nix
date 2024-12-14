{
  config,
  lib,
  pkgs,
  flake,
  ...
}: {
  options = {
    ggorg.compat = {
      enable = lib.mkEnableOption "compatibility with non-NixOS programs" // {default = true;};
      appimage = lib.mkEnableOption "AppImage compatibility" // {default = true;};
    };
  };

  config = lib.mkIf config.ggorg.compat.enable {
    environment.systemPackages = [
      pkgs.steam-run

      flake.inputs.nix-alien.packages.${pkgs.system}.nix-alien
    ];

    programs.nix-ld.enable = true;

    programs.appimage = {
      enable = config.ggorg.compat.appimage;
      binfmt = true;
    };
  };
}
