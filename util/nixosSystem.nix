{
  # dependencies
  nixpkgs,
  home-manager,
  # system hostname
  hostname,
  # specialArgs
  pkgs-stable,
  inputs,
  system,
  username,
  stateVersion,
  ...
}:
nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {inherit pkgs-stable inputs system username stateVersion;};

  modules = [
    ../hosts/${hostname}/configuration.nix

    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users."${username}" = import ../hosts/${hostname}/home.nix;

        extraSpecialArgs = {inherit pkgs-stable inputs system username stateVersion;};
      };
    }
  ];
}
