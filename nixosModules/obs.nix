{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.obs = {
      enable = lib.mkEnableOption "OBS Studio";
    };
  };

  config = lib.mkIf config.ggorg.obs.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-pipewire-audio-capture
        input-overlay
      ];
    };
  };
}
