{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.development.rust = {
      enable = lib.mkEnableOption "Rust";
    };
  };

  config = lib.mkIf config.ggorg.development.rust.enable {
    home = {
      packages = with pkgs;
        [
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
          cargo-wipe
          cargo-sweep
          cargo-expand
          cargo-generate
          bacon
          evcxr
          watchexec

          sccache
        ]
        ++ (lib.lists.optionals (pkgs.system == "x86_64-linux") [
          mold
        ]);

      file.".cargo/config.toml".source = (pkgs.formats.toml {}).generate "cargo-config" {
        build = {
          rustc-wrapper = lib.getExe pkgs.sccache;
        };
        target.x86_64-unknown-linux-gnu.rustflags = ["-C" "link-arg=-fuse-ld=mold"];
        alias = {
          b = "build";
          br = "build --release";
          c = "clippy";
          r = "run";
          rr = "run --release";
        };
      };
    };
  };
}
