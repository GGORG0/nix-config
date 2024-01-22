{
  pkgs,
  username,
  ...
}: {
  # Enable KVM virtualization
  virtualisation.libvirtd.enable = true;
  users.extraUsers."${username}".extraGroups = ["libvirtd"];

  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';

  environment.systemPackages = [pkgs.virt-manager];
}
