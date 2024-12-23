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
    environment.systemPackages = with pkgs; [
      (rust-bin.selectLatestNightlyWith
        (toolchain:
          toolchain.default.override {
            extensions = ["rust-src" "rust-analyzer"];
          }))

      # Useful tools
      cargo-info
      cargo-cache
      cargo-edit
      cargo-udeps
      cargo-sort
      bacon
    ];
  };
}
