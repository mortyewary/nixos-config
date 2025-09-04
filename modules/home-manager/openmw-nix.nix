{ config, pkgs, inputs, ... }:

let
  # All OpenMW packages for your system
  openmwPkgs = inputs.openmw-nix.packages.${pkgs.system};
in
{
  # -----------------------------
  # Packages
  # -----------------------------
  home.packages = with openmwPkgs; [
    delta-plugin         # Save game delta compression plugin
    openmw-validator     # Save file validator
    momw-configurator    # GUI configuration tool
    s3lightfixes         # Light fixes for OpenMW
    umo                  # Unofficial Morrowind Overhaul
    curldl               # Asset downloader for OpenMW
    groundcoverify       # Groundcover enhancements
    plox                 # Additional plugin
  ];
}