{
  config,
  lib,
  flake,
  ...
}: {
  imports = [
    flake.inputs.nix-index-database.homeModules.nix-index
  ];

  options = {
    ggorg.nix-index = {
      enable = lib.mkEnableOption "nix-index, comma and databases" // {default = true;};
    };
  };

  config = lib.mkIf config.ggorg.nix-index.enable {
    programs.nix-index.enable = true;
    programs.nix-index-database.comma.enable = true;
  };
}
