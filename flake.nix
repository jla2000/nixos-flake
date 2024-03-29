{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
    in
    rec {
      imports = [ inputs.pre-commit-hooks.flakeModule ];
      pre-commit.settings = { hooks.nixpkgs-fmt.enable = true; };

      overlays = [
        inputs.nur.overlay
        (final: prev: {
          unstable = inputs.nixpkgs-unstable.legacyPackages.${final.system};
          neovim-unstable = inputs.neovim-nightly.packages.${final.system}.default;
        })
      ];

      nixosConfigurations."zephyrus" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          pkgs = import nixpkgs {
            inherit system;
            inherit overlays;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/zephyrus/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jan = import ./hosts/zephyrus/home.nix;
          }
        ];
      };

      homeConfigurations."jlafferton@dell" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          inherit overlays;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "electron-25.9.0"
            ];
          };
        };
        modules = [ ./hosts/dell/home.nix ];
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
}
