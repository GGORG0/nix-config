{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;

      # Very cool that NixOS has those!
      memtest86.enable = true;
      netbootxyz.enable = true;
    };
    efi.canTouchEfiVariables = true;
  };
  boot.initrd.systemd.enable = true; # Mainly for TPM2 LUKS locking
  environment.systemPackages = [pkgs.tpm2-tss];
}
