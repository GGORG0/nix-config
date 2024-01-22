{username, ...}: {
  users.users."${username}" = {
    isNormalUser = true;
    description = "GGORG";
    extraGroups = ["wheel"];
    # shell = pkgs.zsh; FIXME: add zsh config to home-manager
  };
}
