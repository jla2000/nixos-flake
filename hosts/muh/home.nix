{ pkgs, ... }:
{
  imports = [
    ../../modules/shell
  ];

  programs.home-manager.enable = true;

  home = {
    username = "jan";
    homeDirectory = "/home/jan";
    stateVersion = "23.11";
  };

  programs.git = {
    enable = true;
    userName = "Jan Lafferton";
    userEmail = "jan@lafferton.de";
  };
}
