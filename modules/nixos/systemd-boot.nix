{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  boot.loader = {
    systemd-boot = {
      # Secure boot via Lanzaboote
      # Lanzaboote currently replaces the systemd-boot module.
      # This setting is usually set to true in configuration.nix
      # generated at installation time. So we force it to false
      # for now.
      enable = lib.mkForce false;

      configurationLimit = 10;

      # Very cool that NixOS has those!
      memtest86.enable = true;
      netbootxyz.enable = true;
    };
    efi.canTouchEfiVariables = true;
  };

  # Secure boot (run sudo sbctl create-keys first)
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  environment.systemPackages = with pkgs; [
    # TPM2 LUKS auto-unlocking
    tpm2-tss
    # Secure boot key management
    sbctl
  ];

  # TPM2 LUKS auto-unlocking
  boot.initrd.systemd.enable = true;

  # enables the SysRq key in case of system freezes
  boot.kernel.sysctl."kernel.sysrq" = 1;
}
