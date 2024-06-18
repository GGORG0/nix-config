{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.zsh.direnv.enable = lib.mkEnableOption "direnv";
  };

  config = lib.mkIf config.ggorg.zsh.direnv.enable {
    # automatically activate development environment
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
