{
  pkgs,
  username,
  inputs,
  ...
}: {
  nixpkgs.overlays = [inputs.rust-overlay.overlays.default];

  # TODO: use options to make stuff opt-in
  # System packages related to development
  environment.systemPackages = with pkgs; [
    # C/C++ compilation + linking
    gcc
    gnumake
    cmake

    # Rust
    (rust-bin.selectLatestNightlyWith
      (toolchain:
        toolchain.default.override {
          extensions = ["rust-src" "rust-analyzer"];
        }))

    # Python
    python311Full
    python311Packages.ipython

    # Arduino
    arduino-ide
  ];

  # Android Debug Bridge
  programs.adb.enable = true;
  users.users."${username}".extraGroups = ["adbusers"];

  # Docker
  virtualisation.docker.enable = true;
}
