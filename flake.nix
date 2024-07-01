{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zellij = {
      url = "github:zellij-org/zellij";
      flake = false;
    };
    helix = {
      url = "github:jla2000/helix/rounded-corners";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-bat-theme = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-lazygit-theme = {
      url = "github:catppuccin/lazygit";
      flake = false;
    };
    lz-n = {
      url = "github:nvim-neorocks/lz.n";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    huez-nvim = {
      url = "github:vague2k/huez.nvim";
      flake = false;
    };
    oil-nvim = {
      url = "github:stevearc/oil.nvim";
      flake = false;
    };
    nerdy-nvim = {
      url = "github:2KAbhishek/nerdy.nvim";
      flake = false;
    };
    markview-nvim = {
      url = "github:OXY2DEV/markview.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";

      overlays = [
        (final: prev:
          let
            oil-nvim = nixpkgs.legacyPackages.${final.system}.vimUtils.buildVimPlugin {
              name = "oil.nvim";
              src = inputs.oil-nvim;
            };
            huez-nvim = nixpkgs.legacyPackages.${final.system}.vimUtils.buildVimPlugin {
              name = "huez.nvim";
              src = inputs.huez-nvim;
            };
            nerdy-nvim = nixpkgs.legacyPackages.${final.system}.vimUtils.buildVimPlugin {
              name = "nerdy.nvim";
              src = inputs.nerdy-nvim;
            };
            markview-nvim = nixpkgs.legacyPackages.${final.system}.vimUtils.buildVimPlugin {
              name = "markview.nvim";
              src = inputs.markview-nvim;
            };
          in
          {
            helix = inputs.helix.packages.${final.system}.default;
            vimPlugins = prev.vimPlugins // {
              inherit oil-nvim;
              inherit huez-nvim;
              inherit nerdy-nvim;
              inherit markview-nvim;
            };
          })
        inputs.lz-n.outputs.overlays.default
      ];
    in
    {
      homeManagerModules.shell = {
        imports = [ ./modules/shell ];
      };

      overlays.default = overlays;
    };
}
