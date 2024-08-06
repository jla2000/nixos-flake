{ inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
    inputs.home-manager.nixosModules.home-manager
    ../../modules/system/nixpkgs-vector.nix
    ../../modules/system/stylix.nix
    ../../modules/system/nix.nix
  ];

  wsl = {
    enable = true;
    wslConf.automount.root = lib.mkDefault "/mnt";
    defaultUser = lib.mkDefault "jlafferton";
    startMenuLaunchers = lib.mkDefault true;
  };

  home-manager.users.jlafferton = import ./home.nix;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";

  programs.nix-index-database.comma.enable = true;


  virtualisation.docker.enable = lib.mkDefault true;

  # minimal packages
  environment.systemPackages = with pkgs; [
    git
    htop
    vim
    wget # needed for vscode
    neovim
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
