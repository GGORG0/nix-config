{
  username,
  pkgs,
  ...
}: {
  users.users."${username}" = {
    isNormalUser = true;
    description = "GGORG";
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };
}
