{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  ggorg = {
    development = {
      adb.enable = true;
      arduino.enable = true;
      gcc.enable = true;
      python.enable = true;
      rust.enable = true;
    };
    gui = {
      fonts.enable = true;
      plasma.enable = true;
    };
    hardware = {
      bluetooth.enable = true;
      hpPrinter.enable = true;
      libinput.enable = true;
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
  };

  # Disable wakeup from the magnetic keyboard
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="60a3", ATTR{power/wakeup}="disabled"
  '';
}
