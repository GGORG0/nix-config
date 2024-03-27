{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
    ./plugins.nix
    ./lsp.nix
    ./keybinds.nix
  ];

  programs.nixvim = {
    enable = true;

    vimAlias = true;
    viAlias = true;

    colorschemes.catppuccin.enable = true;
  };
}
