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
      gnome = {
        enable = true;
        gdm.enable = true;
      };
    };
    hardware = {
      bluetooth.enable = true;
      em7455.enable = true;
      hpPrinter.enable = true;
      iioSensors.enable = true;
      libinput.enable = true;
      opengl.enable = true;
      sound.enable = true;
      wacom.enable = true;
    };
    boot = {
      systemd-boot = {
        enable = true;
        timeout = 1;
      };
      sysrq = 383;
    };
    docker.enable = true;
    network = {
      enable = true;
      firewall.enable = false;
      ssh.enable = true;
    };
  };

  # Disable wakeup from the magnetic keyboard
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="60a3", ATTR{power/wakeup}="disabled"
  '';
}
