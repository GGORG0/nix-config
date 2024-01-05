{
  lib,
  config,
  pkgs,
  username,
  stateVersion,
  ...
}: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "${stateVersion}";
  };

  # TODO: move to module
  programs.git = {
    enable = true;
    userName = "GGORG";
    userEmail = "GGORG0@protonmail.com";
    aliases = {
      co = "checkout";
      cm = "commit";
      pu = "push";
      pl = "pull";
      st = "status";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
