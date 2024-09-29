{ lib
, config
, ...
}: {
  imports = [
    ./aliases.nix
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./starship.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  options = {
    ggorg.zsh.enable = lib.mkEnableOption "Zsh";
  };

  config = lib.mkIf config.ggorg.zsh.enable {
    # Enable other components
    ggorg.zsh = {
      aliases.enable = lib.mkDefault true;
      bat.enable = lib.mkDefault true;
      direnv.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      fzf.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      zoxide.enable = lib.mkDefault true;
    };
  };
}
