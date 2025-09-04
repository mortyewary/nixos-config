{ config, pkgs, inputs, ... }:

[
  ./boot.nix
  ./gpu.nix
  ./networking.nix
  ./locale.nix
  ./users.nix
  ./packages.nix
  ./fonts.nix
  ./environment.nix
  ./desktop.nix
  ./services.nix
  ./audio.nix
  ./power.nix
]
