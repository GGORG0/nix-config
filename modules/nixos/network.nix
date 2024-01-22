{username, ...}: {
  # Enable networking
  networking.networkmanager.enable = true;

  # Disable the firewall completely
  networking.firewall.enable = false;

  # Rootless NetworkManager control
  users.extraUsers."${username}".extraGroups = ["networkmanager"];
}
