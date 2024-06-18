{
  flake,
  lib,
  config,
  ...
}: {
  imports = [
    flake.inputs.nixvim.homeManagerModules.nixvim

    ./options.nix
    ./plugins.nix
    ./lsp.nix
    ./keybinds.nix
  ];

  options = {
    ggorg.neovim = {
      enable = lib.mkEnableOption "Neovim";
    };
  };

  config = {
    programs.nixvim = {
      inherit (config.ggorg.neovim) enable;

      vimAlias = true;
      viAlias = true;

      colorschemes.catppuccin.enable = true;
    };
  };
}
