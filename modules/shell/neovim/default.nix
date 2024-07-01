{ inputs, pkgs, ... }:
let
  treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitter.dependencies;
  };
  oil-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "oil.nvim";
    src = inputs.oil-nvim;
  };
  huez-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "huez.nvim";
    src = inputs.huez-nvim;
  };
  nerdy-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "nerdy.nvim";
    src = inputs.nerdy-nvim;
  };
  markview-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "markview.nvim";
    src = inputs.markview-nvim;
  };
in
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lz-n
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-frecency-nvim
      oil-nvim
      nvim-treesitter
      nvim-treesitter-textobjects
      nvim-treesitter-context
      tokyonight-nvim
      catppuccin-nvim
      onedark-nvim
      adwaita-nvim
      zenbones-nvim
      lush-nvim
      flash-nvim
      nvim-lspconfig
      indent-blankline-nvim
      cmake-tools-nvim
      nvim-web-devicons
      nvim-autopairs
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      luasnip
      conform-nvim
      marks-nvim
      lualine-nvim
      better-escape-nvim
      gitsigns-nvim
      persistence-nvim
      yanky-nvim
      noice-nvim
      nui-nvim
      trouble-nvim
      nvim-surround
      lazydev-nvim
      dressing-nvim
      huez-nvim
      lazy-nvim
      crates-nvim
      diffview-nvim
      nerdy-nvim
      markview-nvim
    ];
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      nixd
      nixpkgs-fmt
      markdownlint-cli
      rust-analyzer
      rustfmt
    ];
    defaultEditor = true;
  };

  home.shellAliases = {
    v = "nvim";
  };

  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
  xdg.configFile."nvim/lua".source = ./nvim/lua;
  xdg.configFile."nvim/parser".source = "${treesitter-parsers}/parser";
}
