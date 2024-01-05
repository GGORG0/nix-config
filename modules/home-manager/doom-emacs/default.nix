{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-doom-emacs.hmModule
  ];

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
}
