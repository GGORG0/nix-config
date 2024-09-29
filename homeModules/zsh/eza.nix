{ config
, lib
, ...
}: {
  options = {
    ggorg.zsh.eza.enable = lib.mkEnableOption "eza";
  };

  config = lib.mkIf config.ggorg.zsh.eza.enable {
    # ls replacement
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = true;
    };
  };
}
