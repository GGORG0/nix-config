_: {
  programs = {
    zsh = {
      enable = true;

      autocd = true;

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        share = true;
      };

      shellAliases = {
        cd = "z"; # zoxide
      };

      enableCompletion = true;
      enableVteIntegration = true;

      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
    };

    # cd replacement, which allows for faster navigation
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # i only use it for history fuzzy searching
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    # shell prompt
    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    # cat replacement with syntax highlighting
    bat.enable = true;

    # ls replacement
    eza = {
      enable = true;
      git = true;
      icons = true;
    };

    # automatically activate development environment
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home.shellAliases = {
    # Colored commands
    grep = "grep --color=auto";
    egrep = "egrep --color=auto";
    fgrep = "fgrep --color=auto";
    diff = "diff --color=auto";
    ip = "ip --color=auto";

    # Bat
    cat = "bat";

    # Useful
    mkdir = "mkdir -p";
    cp = "cp -r";
    du = "du -h";

    # Make sudo expand aliases
    sudo = "sudo ";
  };
}
