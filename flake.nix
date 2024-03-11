{
  description = "GGORG's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    pre-commit-hooks,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    username = "ggorg";

    stateVersion = "23.11";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    # Nix language file formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    # Pre-commit hooks
    checks.${system}.default = pre-commit-hooks.lib.${system}.run {
      src = ./.;
      hooks = {
        alejandra.enable = true;
        statix.enable = true;
        deadnix.enable = true;
      };
    };
    devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
      inherit (self.checks.${system}.default) shellHook;

      packages = with pkgs; [
        alejandra # formatter
        statix # linter
        deadnix # scan for dead code
        nil # language server
      ];
    };

    nixosConfigurations = {
      # My HP EliteBook 650 G9
      ggorg-elitebook = import ./util/nixosSystem.nix {
        inherit nixpkgs home-manager pkgs-stable inputs system username stateVersion;
        hostname = "ggorg-elitebook";
      };

      # My ThinkPad X1 Tablet 2nd gen
      ggorg-x1tablet = import ./util/nixosSystem.nix {
        inherit nixpkgs home-manager pkgs-stable inputs system username stateVersion;
        hostname = "ggorg-x1tablet";
      };
    };
  };
}
