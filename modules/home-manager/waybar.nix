{ pkgs, ... }:

let
  # Wrap all scripts in the scripts/ folder as shell binaries
  waybarScripts = builtins.attrValues (builtins.listToAttrs (map (script: {
    name = builtins.basename script;
    value = pkgs.writeShellScriptBin (builtins.basename script) script;
  }) (builtins.readDir ./waybar/scripts)));
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    # Load JSON config files
    settings = builtins.fromJSON (builtins.readFile ./waybar/config.jsonc);

    # Load CSS (includes theme via @import)
    style = builtins.readFile ./waybar/style.css;
  };

  # Add scripts to home.packages so they are in $PATH
  home.packages = waybarScripts;

  # Ensure themes folder exists if referenced in style.css
  home.file.".config/waybar/themes" = {
    source = ./waybar/themes;
    recursive = true;
  };
}
