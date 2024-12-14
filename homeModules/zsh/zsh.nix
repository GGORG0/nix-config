{config, ...}: {
  config = {
    programs.zsh = {
      inherit (config.ggorg.zsh) enable;

      autocd = true;

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        share = true;
      };

      enableCompletion = true;
      enableVteIntegration = true;

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
