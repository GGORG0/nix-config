{
  description = "GGORG's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    username = "ggorg";

    stateVersion = "23.11";
  in {
    # Nix language file formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations = {
      # My HP EliteBook 650 G9
      ggorg-elitebook = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs system username stateVersion;};

        modules = [
          ./hosts/ggorg-elitebook/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users."${username}" = import ./hosts/ggorg-elitebook/home.nix;

              extraSpecialArgs = {inherit inputs system username stateVersion;};
            };
          }
        ];
      };

      # My ThinkPad X1 Tablet 2nd gen
      ggorg-x1tablet = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs system username stateVersion;};

        modules = [
          ./hosts/ggorg-x1tablet/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users."${username}" = import ./hosts/ggorg-x1tablet/home.nix;

              extraSpecialArgs = {inherit inputs system username stateVersion;};
            };
          }
        ];
      };
    };
  };
}
