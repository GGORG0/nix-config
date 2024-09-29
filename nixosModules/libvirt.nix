{ pkgs
, config
, lib
, ...
}: {
  options = {
    ggorg.libvirt = {
      enable = lib.mkEnableOption "QEMU, KVM and libvirt";
    };
  };

  config = lib.mkIf config.ggorg.libvirt.enable {
    virtualisation.libvirtd.enable = true;
    ggorg.user.extraGroups = [ "libvirtd" ];

    boot.extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1
    '';

    environment.systemPackages = [ pkgs.virt-manager ];
  };
}
