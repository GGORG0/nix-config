{
  flake,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    flake.inputs.nixvim.homeManagerModules.nixvim

    ./plugins
    ./options.nix
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

      defaultEditor = true;
      vimdiffAlias = true;

      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      extraPackages = with pkgs; [
        ripgrep
        fd
        fzf
      ];

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          show_end_of_buffer = true;
          transparent_background = true;
          dim_inactive.enabled = true;
          integrations = {
            noice = true;
            notify = true;
            which_key = true;
          };
        };
      };
    };
  };
}
