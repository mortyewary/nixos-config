{ inputs, pkgs, ... }:

{
  imports = [
    ./modules/home-manager
  ];

  home.username = "waylon";
  home.homeDirectory = "/home/waylon";
  home.stateVersion = "25.05";
}
