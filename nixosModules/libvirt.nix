{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    ggorg.libvirt = {
      enable = lib.mkEnableOption "QEMU, KVM and libvirt";
    };
  };

  config = lib.mkIf config.ggorg.libvirt.enable {
    virtualisation.libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };

    ggorg.user.extraGroups = ["libvirtd" "kvm"];

    boot.extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1
    '';

    environment.systemPackages = [pkgs.virt-manager];
  };
}
