{ config
, lib
, ...
}: {
  options = {
    ggorg.zsh.zoxide.enable = lib.mkEnableOption "Zoxide";
  };

  config = lib.mkIf config.ggorg.zsh.zoxide.enable {
    # cd replacement, which allows for faster navigation
    programs = {
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      zsh.shellAliases.cd = "z";
    };
  };
}
