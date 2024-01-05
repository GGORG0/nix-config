# boilerplate for autostarting a service with user systemd
#
# meant to be used like this in home-manager:
# programs.waybar = {
#   [...]
#   systemd = import ./systemd-bp.nix;
#   [...]
# }
# TODO: using options is probably a better practice than this, right...?
{
  enable = true;
  target = "hyprland-session.target";
}
