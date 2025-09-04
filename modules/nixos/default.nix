# modules/nixos/default.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    ./audio.nix
    ./boot.nix
    ./desktop.nix
    ./environment.nix
    ./fonts.nix
    ./gpu.nix
    ./locale.nix
    ./networking.nix
    ./packages.nix
    ./power.nix
    ./services.nix
    ./users.nix
  ];
}
