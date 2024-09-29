{ config
, lib
, ...
}: {
  options = {
    ggorg.zsh.fzf.enable = lib.mkEnableOption "fzf";
  };

  config = lib.mkIf config.ggorg.zsh.fzf.enable {
    # I only use it for history fuzzy searching
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
