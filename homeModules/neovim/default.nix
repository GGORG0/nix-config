{ flake
, lib
, config
, pkgs
, ...
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

      extraPackages = with pkgs; [
        ripgrep
        fd
        fzf
      ];

      performance = {
        byteCompileLua = {
          enable = true;
          configs = true;
          nvimRuntime = true;
          plugins = true;
        };
      };
    };
  };
}
