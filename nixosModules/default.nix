{...}: {
  imports = [
    ./gui
    ./hardware
    ./boot.nix
    ./common-pkgs.nix
    ./compat.nix
    ./docker.nix
    ./gnupg.nix
    ./keyring.nix
    ./libvirt.nix
    ./locale.nix
    ./network.nix
    ./nix-conf.nix
    ./obs.nix
    ./steam.nix
    ./tailscale.nix
    ./user.nix
  ];
}
