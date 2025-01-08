{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  ggorg = {
    gui = {
      fonts.enable = true;
      plasma.enable = true;
    };
    hardware = {
      adb.enable = true;
      bluetooth.enable = true;
      em7455.enable = true;
      hpPrinter.enable = true;
      iioSensors.enable = true;
      libinput.enable = true;
      lmsensors.enable = true;
      opengl.enable = true;
      power.enable = true;
      qmk.enable = false;
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
    docker.enable = false;
    libvirt.enable = false;
    network = {
      enable = true;
      firewall.enable = false;
      ssh.enable = true;
    };
    obs.enable = false;
    steam.enable = false;
    tailscale.enable = true;
    keyring.enable = true;
  };

  # Disable wakeup from the magnetic keyboard
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="60a3", ATTR{power/wakeup}="disabled"
  '';
}
