{
  description = "GGORG's Nix configuration";

  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: REMOVE THIS
    # Temporary fix for https://github.com/NixOS/nixpkgs/issues/370011
    # Relevant until https://github.com/NixOS/nixpkgs/pull/370637 gets merged to nixos-unstable
    nixpkgs-xsane-fix.url = "github:timhae/nixpkgs/fix-build-failure";

    # Management of this flake
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust managed by Nix
    rust-overlay.url = "github:oxalica/rust-overlay";

    # Neovim managed by Nix
    nixvim = {
      url = "github:nix-community/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs"; # https://github.com/nix-community/nixvim/issues/1699
    };

    # Run non-NixOS, dynamically compiled programs easily
    nix-alien.url = "github:thiagokokada/nix-alien";

    # Find which package has a file in it
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      imports = [
        inputs.nixos-unified.flakeModule
        inputs.pre-commit-hooks.flakeModule
      ];

      perSystem = {
        self',
        config,
        pkgs,
        ...
      }: {
        packages.default = self'.packages.activate;

        formatter = pkgs.alejandra;

        pre-commit.settings = {
          hooks = {
            alejandra.enable = true;
            statix.enable = true;
            deadnix.enable = true;
            nil.enable = true;
          };
        };

        devShells.default = pkgs.mkShell {
          shellHook = ''
            ${config.pre-commit.installationScript}
          '';

          packages = with pkgs; [
            alejandra # formatter
            statix # linter
            deadnix # scan for dead code
            nil # language server
          ];
        };
      };

      flake = let
        username = "ggorg";
        stateVersion = "24.05";

        mkNixosSystem = {
          hostname,
          hostPlatform,
        }:
          self.nixos-unified.lib.mkLinuxSystem {home-manager = true;} {
            nixpkgs = {
              inherit hostPlatform;
              config.allowUnfree = true;
              overlays = [
                inputs.rust-overlay.overlays.default

                # TODO: REMOVE THIS
                # Temporary fix for xsane
                (_final: (prev: {
                  inherit (import inputs.nixpkgs-xsane-fix {inherit (prev) system;}) xsane;
                }))
              ];
            };

            system = {
              inherit stateVersion;
            };

            networking.hostName = hostname;

            imports = [
              ./hosts/${hostname}/configuration.nix
              ./nixosModules

              {
                home-manager = {
                  users.${username} = {
                    home = {
                      inherit stateVersion;
                    };

                    xdg.enable = true;

                    # Nicely reload system units when changing configs
                    systemd.user.startServices = "sd-switch";

                    nixpkgs.config = {
                      allowUnfree = true;
                      # Workaround for https://github.com/nix-community/home-manager/issues/2942
                      allowUnfreePredicate = _: true;
                    };

                    imports = [
                      ./hosts/${hostname}/home.nix
                      ./homeModules
                    ];
                  };

                  useGlobalPkgs = true;
                  useUserPackages = true;
                };
              }
            ];
          };
      in {
        nixosConfigurations = {
          ggorg-elitebook = mkNixosSystem {
            hostname = "ggorg-elitebook";
            hostPlatform = "x86_64-linux";
          };
          ggorg-x1tablet = mkNixosSystem {
            hostname = "ggorg-x1tablet";
            hostPlatform = "x86_64-linux";
          };
        };
      };
    };
}
