{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.hardware.opengl = {
      enable = lib.mkEnableOption "OpenGL";
    };
  };

  config = lib.mkIf config.ggorg.hardware.opengl.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
    };
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # LIBVA_DRIVER_NAME=i965
        libvdpau-va-gl
        intel-media-sdk
        vpl-gpu-rt

        libva
        vaapiVdpau
        intel-compute-runtime
      ];
    };
    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD"; # Force intel-media-driver

    environment.systemPackages = [
      pkgs.nvtopPackages.intel
    ];
  };
}
