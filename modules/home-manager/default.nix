# modules/home-manager/default.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./openmw-nix.nix
    ./packages.nix
    ./wayland.nix
    ./waybar.nix
  ];
}

