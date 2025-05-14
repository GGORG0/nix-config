{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.hardware.libinput = {
      enable = lib.mkEnableOption "Libinput";
    };
  };

  config = lib.mkIf config.ggorg.hardware.libinput.enable (let
    libinputPkg = pkgs.libinput.override {eventGUISupport = true;};
  in {
    services.libinput.enable = true;
    environment.systemPackages = [
      libinputPkg
    ];

    ggorg.user.extraGroups = ["input"];
  });
}
