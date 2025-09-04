# modules/home-manager/default.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./git.nix
    ./hyprland.nix
    ./openmw-nix.nix
    ./packages.nix
    ./wayland.nix
    #./waybar.nix
  ];
}

