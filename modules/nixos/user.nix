{
  username,
  pkgs,
  ...
}: {
  users.users."${username}" = {
    isNormalUser = true;
    description = "GGORG";
    extraGroups = [
      "wheel"
      "video" # for Waybar backlight permission
      "docker"
      "dialout" # UART USB devices (arduino)
    ];
    shell = pkgs.zsh;
  };
}
