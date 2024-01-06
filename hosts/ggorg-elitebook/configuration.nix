{
  pkgs,
  lib,
  config,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/nix-conf.nix # Nix package manager configuration
    ../../modules/nixos/locale.nix # Timezone + locale

    ../../modules/nixos/systemd-boot.nix # The systemd-boot bootloader
    ../../modules/nixos/hardware.nix # Hardware configuration
    ../../modules/nixos/network.nix # NetworkManager & firewall

    ../../modules/nixos/user.nix # The main user account
    ../../modules/nixos/common-pkgs.nix # My frequently used command-line tools
    ../../modules/nixos/gui.nix # Common GUI, fonts and sound configuration

    ../../modules/nixos/hyprland.nix # Hyprland rice system config

    ../../modules/nixos/development.nix # Development & compilation tools

    ../../modules/nixos/qemu-kvm.nix # QEMU/KVM + libvirt + virt-manager
  ];

  # LUKS encryption
  boot.initrd.luks.devices."luks-61a90f5f-e22d-4c85-ba0d-8f3c83dd90a8".device = "/dev/disk/by-uuid/61a90f5f-e22d-4c85-ba0d-8f3c83dd90a8";

  # Hostname
  networking.hostName = "ggorg-elitebook";

  # OpenSSH daemon TODO: move to module
  services.openssh.enable = true;

  # Enable options from hardware.nix (not to be confused with hardware-configuration.nix!)
  hardwarePresets = {
    bluetooth = true;
    wacom = true;
    sound = true;
    opengl = true;
    touchpad = true;
    printer = true;
  };
}
