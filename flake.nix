{
  description = "GGORG's Nix configuration";

  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module?ref=release-2.92";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
              config = {
                allowUnfree = true;
                allowUnfreePredicate = _: true;
              };
              overlays = [
                inputs.rust-overlay.overlays.default
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

                    xdg = {
                      enable = true;
                      userDirs = {
                        enable = true;
                        createDirectories = true;
                      };
                    };

                    # Nicely reload system units when changing configs
                    systemd.user.startServices = "sd-switch";

                    imports = [
                      ./hosts/${hostname}/home.nix
                      ./homeModules
                    ];
                  };

                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "hmbak";
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
          ggorg-x395 = mkNixosSystem {
            hostname = "ggorg-x395";
            hostPlatform = "x86_64-linux";
          };
        };
      };
    };
}
