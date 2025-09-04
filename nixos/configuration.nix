{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/nixos  # Only one line for all modules
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  system.stateVersion = "25.05";
}
