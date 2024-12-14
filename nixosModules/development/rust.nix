{
  config,
  lib,
  pkgs,
  flake,
  ...
}: {
  options = {
    ggorg.development.rust = {
      enable = lib.mkEnableOption "Rust";
    };
  };

  config = lib.mkIf config.ggorg.development.rust.enable {
    nixpkgs.overlays = [flake.inputs.rust-overlay.overlays.default];
    environment.systemPackages = [
      (pkgs.rust-bin.selectLatestNightlyWith
        (toolchain:
          toolchain.default.override {
            extensions = ["rust-src" "rust-analyzer"];
          }))
    ];
  };
}
