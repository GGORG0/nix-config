{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    ggorg.zsh.bat.enable = lib.mkEnableOption "Bat";
  };

  config = lib.mkIf config.ggorg.zsh.bat.enable {
    # cat replacement with syntax highlighting
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batpipe prettybat batwatch];
    };

    home.shellAliases.cat = "bat";
  };
}
