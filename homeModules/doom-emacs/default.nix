{
  pkgs,
  flake,
  lib,
  config,
  ...
}: {
  imports = [
    flake.inputs.nix-doom-emacs.hmModule
  ];

  options = {
    ggorg.doomEmacs = {
      enable = lib.mkEnableOption "Doom Emacs";
    };
  };

  config = lib.mkIf config.ggorg.doomEmacs.enable {
    home.packages = [
      pkgs.ispell
      (pkgs.aspellWithDicts (dicts: with dicts; [en en-computers en-science pl]))
    ];

    programs.doom-emacs = rec {
      enable = true;
      doomPrivateDir = ./doom.d;
      doomPackageDir = pkgs.linkFarm "doom-package-dir" [
        {
          name = "config.el";
          path = pkgs.emptyFile;
        }
        {
          name = "init.el";
          path = ./doom.d/init.el;
        }
        {
          name = "packages.el";
          path = ./doom.d/packages.el;
        }
      ];
      emacsPackage = pkgs.emacs28;
    };

    services.emacs = {
      enable = true;
      startWithUserSession = "graphical";
      defaultEditor = true;
      client.enable = true;
    };
  };
}
