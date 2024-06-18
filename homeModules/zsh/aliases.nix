{
  config,
  lib,
  ...
}: {
  options = {
    ggorg.zsh.aliases.enable = lib.mkEnableOption "shell aliases";
  };

  config = lib.mkIf config.ggorg.zsh.aliases.enable {
    home.shellAliases = {
      # Colored commands
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      diff = "diff --color=auto";
      ip = "ip --color=auto";

      # Useful
      mkdir = "mkdir -p";
      cp = "cp -r";
      du = "du -h";

      # Make sudo expand aliases
      sudo = "sudo ";
    };
  };
}
