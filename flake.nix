{
  description = "GGORG's Nix configuration";

  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Management of this flake
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Doom Emacs managed by Nix (to be replaced by Nixvim)
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    # Rust managed by Nix
    rust-overlay.url = "github:oxalica/rust-overlay";

    # Neovim managed by Nix
    nixvim = {
      url = "github:nix-community/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs"; # https://github.com/nix-community/nixvim/issues/1699
    };

    # Hyprland and friends
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    xdg-desktop-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprlock.url = "github:hyprwm/hyprlock";
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      imports = [
        inputs.nixos-flake.flakeModule
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
          self.nixos-flake.lib.mkLinuxSystem {
            nixpkgs = {
              inherit hostPlatform;
              config.allowUnfree = true;
            };

            system = {
              inherit stateVersion;
            };

            networking.hostName = hostname;

            imports = [
              ./hosts/${hostname}/configuration.nix
              ./nixosModules

              self.nixosModules.home-manager

              {
                home-manager = {
                  users.${username} = {
                    home = {
                      inherit stateVersion;
                    };

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
