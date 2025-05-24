{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # LUKS encryption
  boot.initrd.luks.devices."luks-2eb7e93a-802e-4774-ac2e-5eb129f405b1".device = "/dev/disk/by-uuid/2eb7e93a-802e-4774-ac2e-5eb129f405b1";

  ggorg = {
    gui = {
      fonts.enable = true;
      hyprland.enable = true;
      greetd = {
        enable = true;
        autologin = true;
      };
    };
    hardware = {
      adb.enable = true;
      bluetooth.enable = true;
      flipper.enable = true;
      fprint.enable = true;
      hpPrinter.enable = true;
      libinput.enable = true;
      lmsensors.enable = true;
      opengl.enable = true;
      platformio.enable = true;
      power.enable = true;
      qmk.enable = true;
      saleae.enable = true;
      sound.enable = true;
      wacom.enable = true;
      yubikey.enable = true;
    };
    boot = {
      systemd-boot = {
        enable = true;
        timeout = 1;
      };
      sysrq = 1;
    };
    docker.enable = true;
    libvirt.enable = true;
    network = {
      enable = true;
      firewall.enable = false;
      ssh.enable = true;
    };
    obs.enable = true;
    steam.enable = true;
    tailscale.enable = true;
    keyring.enable = true;
  };
}
