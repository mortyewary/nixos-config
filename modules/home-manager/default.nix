{ config, pkgs, inputs, ... }:

[
  ./packages.nix
  ./shell.nix
  ./wayland.nix
  ./git.nix
  ./hyprland.nix
  ./spicetify.nix
  ./openmw-nix.nix
  #  ./waybar.nix
  #  ./colors.nix
]
