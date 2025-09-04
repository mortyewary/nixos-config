{ config, pkgs, inputs, ... }:

{
  home.packages = with inputs.openmw-nix.packages.${pkgs.system}; [
    delta-plugin        # Save game delta compression plugin for OpenMW
    openmw-dev          # Development files for OpenMW
    openmw-validator    # OpenMW save file validator
    momw-configurator   # OpenMW configuration tool
    s3lightfixes        # Light fixes for OpenMW
    umo                 # Unofficial Morrowind Overhaul
    curldl              # Download tool for OpenMW assets
    groundcoverify      # Groundcover enhancements for OpenMW
    plox                # Plox - a plugin for OpenMW
  ];
}
