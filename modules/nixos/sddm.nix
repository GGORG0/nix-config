{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.catppuccin-sddm-corners];
  services.xserver.displayManager.sddm.sddm = {
    enable = true;
    theme = "catppuccin-sddm-corners";
  };
}
