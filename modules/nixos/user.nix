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
    ];
    shell = pkgs.zsh;
  };
}
