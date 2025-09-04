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

  # -----------------------------
  # Environment variables
  # -----------------------------
  home.sessionVariables = {
    OPENMW_USER_DIR = "${config.home.homeDirectory}/.config/openmw";
  };

  # -----------------------------
  # Engine and launcher wrappers
  # -----------------------------
  home.file.".local/bin/openmw".text = ''
    #!/usr/bin/env bash
    export OPENMW_USER_DIR="$HOME/.config/openmw"
    exec ${openmwPkgs.openmw}/bin/openmw "$@"
  '';
  home.file.".local/bin/openmw-launcher".text = ''
    #!/usr/bin/env bash
    export OPENMW_USER_DIR="$HOME/.config/openmw"
    exec ${openmwPkgs.openmw}/bin/openmw-launcher "$@"
  '';

  home.file.".local/bin/openmw".executable = true;
  home.file.".local/bin/openmw-launcher".executable = true;
}
