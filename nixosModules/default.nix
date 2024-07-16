{...}: {
  imports = [
    ./development
    ./gui
    ./hardware
    ./boot.nix
    ./common-pkgs.nix
    ./docker.nix
    ./libvirt.nix
    ./locale.nix
    ./network.nix
    ./nix-conf.nix
    ./obs.nix
    ./steam.nix
    ./user.nix
  ];
}
