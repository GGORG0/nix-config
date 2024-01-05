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

  # TPM2 LUKS auto-unlocking
  boot.initrd.systemd.enable = true;
  environment.systemPackages = [pkgs.tpm2-tss];

  # enables the SysRq key in case of system freezes
  boot.kernel.sysctl."kernel.sysrq" = 1;
}
