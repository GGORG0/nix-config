{ ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  # LUKS encryption
  boot.initrd.luks.devices."luks-61a90f5f-e22d-4c85-ba0d-8f3c83dd90a8".device = "/dev/disk/by-uuid/61a90f5f-e22d-4c85-ba0d-8f3c83dd90a8";

  ggorg = {
    development = {
      adb.enable = true;
      arduino.enable = true;
      dotnet.enable = true;
      gcc.enable = true;
      python.enable = true;
      rust.enable = true;
    };
    gui = {
      fonts.enable = true;
      hyprland.enable = true;
      greetd.enable = true;
    };
    hardware = {
      bluetooth.enable = true;
      hpPrinter.enable = true;
      libinput.enable = true;
      lmsensors.enable = true;
      opengl.enable = true;
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
  };
}
