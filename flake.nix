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
    {
      homeManagerModules.shell = {
        imports = [ 
	  ({ pkgs, ... }: pkgs.callPackage ./modules/shell/default.nix {
	     inherit inputs;
	  })
	];
      };
    };
}
