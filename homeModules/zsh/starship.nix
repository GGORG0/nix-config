{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.zsh.starship.enable = lib.mkEnableOption "Starship prompt";
  };

  config = lib.mkIf config.ggorg.zsh.starship.enable {
    # pretty shell prompt
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
