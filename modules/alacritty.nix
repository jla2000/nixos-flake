{ pkgs, ... }:
let
  catppuccin-alacritty = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "alacritty";
    rev = "f2da554ee63690712274971dd9ce0217895f5ee0";
    hash = "sha256-ypYaxlsDjI++6YNcE+TxBSnlUXKKuAMmLQ4H74T/eLw=";
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 16;
        normal = {
          family = "Monaspace Neon Var";
          style = "Bold";
        };
        bold = {
          family = "Monaspace Neon Var";
          style = "ExtraBold";
        };
        bold_italic = {
          family = "Monaspace Neon Var";
          style = "ExtraBold Italic";
        };
        italic = {
          family = "Monaspace Neon Var";
          style = "Bold Italic";
        };
      };

      window = {
        decorations = "none";
        padding = {
          x = 5;
          y = 5;
        };
      };

      env = {
        TERM = "xterm-256color";
      };
    } // builtins.fromTOML (builtins.readFile (catppuccin-alacritty + /catppuccin-macchiato.toml));
  };
}
